local M = {}

local function create_window()
	vim.cmd("botright vnew")
end

local function focus_last_accessed_window()
	vim.cmd("wincmd p")
end

M.find_project_root = function()
	local current_dir = vim.fn.expand("%:p:h")
	while current_dir ~= "/" do
		if
			vim.fn.filereadable(current_dir .. "/go.mod") == 1
			or vim.fn.filereadable(current_dir .. "/package.json") == 1
			or vim.fn.filereadable(current_dir .. "/.git") == 1
			or vim.fn.filereadable(current_dir .. "/CMakeLists.txt") == 1
		then
			return current_dir
		end
		current_dir = vim.fn.fnamemodify(current_dir, ":h")
	end
	print("Project root not found.")
	return ""
end

M.get_current_file_path = function()
	return vim.fn.expand("%:p")
end

M.create_window = create_window

M.focus_last_accessed_window = focus_last_accessed_window

return M
