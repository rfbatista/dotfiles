local M = {}

local terminal = require("ai.terminal")
local storage = require("ai.terminal.shared.storage")

-- Configuration
local MAX_TABS = 5 -- Maximum number of tabs
local DEFAULT_TAB_NAME = "default"

-- Track last opened tab
local last_opened_tab = nil

---Get or create default tab
---@return string tab_name
local function get_default_tab()
	return DEFAULT_TAB_NAME
end

---Get last opened tab or default
---@return string tab_name
local function get_target_tab()
	if last_opened_tab then
		local term_info = storage.get_named_terminal_info(last_opened_tab)
		if term_info and term_info.term then
			return last_opened_tab
		end
	end
	return get_default_tab()
end

---Get all active tabs
---@return table list of tab names
local function get_active_tabs()
	local tabs = {}
	local named_terminals = storage.get_named_terminals()
	
	for name, info in pairs(named_terminals) do
		if info.term then
			table.insert(tabs, name)
		end
	end
	
	return tabs
end

---Get all active tabs (public function)
---@return table list of tab names
function M.get_active_tabs()
	return get_active_tabs()
end

---Get all tabs (active and inactive)
---@return table list of tab names with their status
function M.get_all_tabs()
	local tabs = {}
	local named_terminals = storage.get_named_terminals()
	
	for name, info in pairs(named_terminals) do
		local is_active = info.term ~= nil
		table.insert(tabs, {
			name = name,
			active = is_active,
			info = info,
		})
	end
	
	return tabs
end

---Remove oldest tab if we exceed max tabs
local function enforce_max_tabs()
	local active_tabs = get_active_tabs()
	
	if #active_tabs > MAX_TABS then
		-- Find oldest tab (by created_at)
		local oldest_name = nil
		local oldest_time = math.huge
		local named_terminals = storage.get_named_terminals()
		
		for name, info in pairs(named_terminals) do
			if info.term and info.created_at and info.created_at < oldest_time then
				-- Don't remove default tab
				if name ~= DEFAULT_TAB_NAME then
					oldest_time = info.created_at
					oldest_name = name
				end
			end
		end
		
		if oldest_name then
			terminal.delete_named(oldest_name)
			vim.notify("Removed oldest tab: " .. oldest_name, vim.log.levels.INFO)
		end
	end
end

---Toggle the target tab (default or last opened)
---@return snacks.win?
function M.toggle()
	local target_tab = get_target_tab()
	
	-- Check if tab exists, if not use default
	local term_info = storage.get_named_terminal_info(target_tab)
	if not term_info or not term_info.term then
		target_tab = get_default_tab()
	end
	
	local term = terminal.toggle_named(target_tab)
	
	if term then
		last_opened_tab = target_tab
		storage.set_active_terminal_name(target_tab)
		enforce_max_tabs()
	end
	
	return term
end

---Switch to a specific tab by name (creates if doesn't exist or restores if inactive)
---@param tab_name string
---@param cmd? string Command to run if creating new
---@return snacks.win?
function M.switch_to_tab(tab_name, cmd)
	local term_info = storage.get_named_terminal_info(tab_name)
	
	-- If tab doesn't exist at all, create it
	if not term_info then
		if not cmd then
			cmd = vim.o.shell
		end
		local term = terminal.create_named(tab_name, cmd)
		if term then
			last_opened_tab = tab_name
			storage.set_active_terminal_name(tab_name)
			enforce_max_tabs()
		end
		return term
	end
	
	-- Tab exists, toggle it (will restore if inactive)
	local term = terminal.toggle_named(tab_name, cmd)
	
	if term then
		last_opened_tab = tab_name
		storage.set_active_terminal_name(tab_name)
		enforce_max_tabs()
	end
	
	return term
end

---Get current active tab
---@return string? tab_name
function M.get_current_tab()
	local active_name = storage.get_active_terminal_name()
	if active_name then
		local term_info = storage.get_named_terminal_info(active_name)
		if term_info and term_info.term then
			return active_name
		end
	end
	return nil
end

---Set last opened tab (called when switching tabs)
---@param tab_name string
function M.set_last_opened_tab(tab_name)
	last_opened_tab = tab_name
end

---Get max tabs limit
---@return number
function M.get_max_tabs()
	return MAX_TABS
end

---Set max tabs limit
---@param max number
function M.set_max_tabs(max)
	MAX_TABS = max
end

return M
