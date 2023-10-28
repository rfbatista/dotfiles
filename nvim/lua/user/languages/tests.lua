local status_ok = pcall(require, "which-key")
if not status_ok then
	return
end

function _JESTER_DEBUG()
	return {
		{
			cmd = "jest -t '$result' -- $file", -- run command
			identifiers = { "test", "it" }, -- used to identify tests
			prepend = { "describe" }, -- prepend describe blocks
			expressions = { "call_expression" }, -- tree-sitter object used to scan for tests/describe blocks
			path_to_jest_run = "jest", -- used to run tests
			path_to_jest_debug = "./node_modules/bin/jest", -- used for debugging
			terminal_cmd = ":vsplit", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
			dap = { -- debug adapter configuration
				type = "node2",
				request = "launch",
				cwd = vim.fn.getcwd(),
				runtimeArgs = { "--inspect-brk", "$path_to_jest", "--no-coverage", "-t", "$result", "--", "$file" },
				args = { "--no-cache" },
				sourceMaps = "inline",
				protocol = "inspector",
				skipFiles = { "<node_internals>/**/*.js" },
				console = "integratedTerminal",
				port = 9229,
				disableOptimisticBPs = true,
			},
		},
	}
end

local config = {}

local function get_current_file_path()
	return vim.fn.expand("%:p")
end

local function create_window()
	vim.cmd("botright vnew")
end

local function get_current_folder_path()
	return vim.fn.expand("%:p:h")
end

local function get_local_jest()
	local root_dir = vim.fn.finddir("node_modules/..", get_current_folder_path() .. ";")
	return root_dir .. "/node_modules/jest/bin/jest.js"
end

local function run_gotest(args)
	local t = {}
	table.insert(t, "terminal " .. config.go_cmd)

	if args ~= nil then
		for _, v in pairs(args) do
			table.insert(t, v)
		end
	end

	local jest_cmd = table.concat(t, "")
	vim.api.nvim_command(jest_cmd)
end

local function run_jest(args)
	local t = {}
	table.insert(t, "terminal " .. config.jest_cmd)

	if args ~= nil then
		for _, v in pairs(args) do
			table.insert(t, v)
		end
	end

	local jest_cmd = table.concat(t, "")
	vim.api.nvim_command(jest_cmd)
end

local function focus_last_accessed_window()
	vim.cmd("wincmd p")
end

function getUnitTest()
	local type = vim.bo.filetype
	if type == "go" then
		return "go test"
	end
	return "npm run test:unit"
end

function getBenchmarkTest()
	local type = vim.bo.filetype
	if type == "go" then
		return "go test -bench=."
	end
end

function getIntegrationTest()
	return "npm run test:intergration"
end

function find_project_root()
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

function Test_file(testCommand)
	local c_file = get_current_file_path()

	local args = {}
	local type = vim.bo.filetype
	config.jest_cmd = testCommand()
	config.go_cmd = testCommand()
	if type == "go" then
		local gotests = require("user.languages.gotests")
		local testName = gotests.findTestName()
		local rootPath = find_project_root()
		local start_idx, end_idx = c_file:find(rootPath)
		local after = c_file:sub(end_idx + 1)
		local gotestargs = " -run " .. testName .. " ." .. after:match(".*/")
		create_window()
		table.insert(args, gotestargs)
		run_gotest(args)
		focus_last_accessed_window()
	elseif type == "lua" then
		find_project_root()
		local gotests = require("user.languages.gotests")
		local testName = gotests.findTestName()
	else
		create_window()
		table.insert(args, " -- --runTestsByPath " .. c_file)
		table.insert(args, " --watch")
		run_jest(args)
		focus_last_accessed_window()
	end
end

local M = {
	keymap = {
		name = "Tests",
		a = { "<cmd>lua Test_file(getUnitTest)<cr>", "Run current unit test file" },
		b = { "<cmd>lua Test_file(getBenchmarkTest)<cr>", "Run benchmark test" },
		i = { "<cmd>lua Test_file(getIntegrationTest)<cr>", "Run current integration test file" },
	},
}

return M
