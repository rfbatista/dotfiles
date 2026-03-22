local M = {}

local TOOLS_DIR = ".tools"
local TABS_FILE = "ai-tabs.json"

---Get repo root (directory containing .git) or cwd as fallback
---@return string
local function get_repo_root()
	local buf_path = vim.api.nvim_buf_get_name(0)
	local dir
	if buf_path and buf_path ~= "" then
		dir = vim.fn.fnamemodify(buf_path, ":p:h")
	else
		dir = vim.fn.getcwd()
	end
	while dir ~= "" and dir ~= "/" do
		local git_dir = dir .. "/.git"
		if vim.fn.isdirectory(git_dir) == 1 or vim.fn.filereadable(git_dir) == 1 then
			return dir
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return vim.fn.getcwd()
end

---Get the .tools directory path for current repo (create if needed)
---@return string path to .tools directory
function M.get_tools_dir()
	local root = get_repo_root()
	local tools_path = root .. "/" .. TOOLS_DIR
	if vim.fn.isdirectory(tools_path) == 0 then
		vim.fn.mkdir(tools_path, "p")
	end
	return tools_path
end

---Get the full path to the tabs JSON file
---@return string
function M.get_tabs_file_path()
	return M.get_tools_dir() .. "/" .. TABS_FILE
end

---Load persisted tabs for current repo
---@return table { [tab_name] = { session_id?: string, cmd?: string }, ... }
function M.load()
	local path = M.get_tabs_file_path()
	local file = io.open(path, "r")
	if not file then
		return {}
	end
	local content = file:read("*all")
	file:close()
	if not content or content == "" then
		return {}
	end
	local ok, data = pcall(vim.json.decode, content)
	if not ok or not data or not data.tabs then
		return {}
	end
	return data.tabs
end

---Save tabs to current repo .tools
---@param tabs table { [tab_name] = { session_id?: string, cmd?: string }, ... }
function M.save(tabs)
	tabs = tabs or {}
	local path = M.get_tabs_file_path()
	local content = vim.json.encode({ tabs = tabs })
	local file = io.open(path, "w")
	if file then
		file:write(content)
		file:close()
	end
end

---Merge in-memory named terminals with persisted tabs (persisted tabs appear as inactive if not in memory)
---@param named_terminals table from storage.get_named_terminals()
---@return table merged list of { name, active, session_id?, cmd?, info? }
function M.merge_with_storage(named_terminals)
	local persisted = M.load()
	local result = {}
	local seen = {}

	for name, info in pairs(named_terminals) do
		seen[name] = true
		local is_active = info.term ~= nil
		local p = persisted[name] or {}
		table.insert(result, {
			name = name,
			active = is_active,
			session_id = p.session_id or info.session_id,
			cmd = p.cmd or (info.cmd and tostring(info.cmd)) or nil,
			info = info,
		})
	end

	for name, p in pairs(persisted) do
		if not seen[name] then
			table.insert(result, {
				name = name,
				active = false,
				session_id = p.session_id,
				cmd = p.cmd,
				info = nil,
			})
		end
	end

	return result
end

return M
