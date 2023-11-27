local helper = require("user.languages.tests.helper")

local M = {}

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

local function get_local_jest()
	local root_dir = vim.fn.finddir("node_modules/..", helper.get_current_folder_path() .. ";")
	return root_dir .. "/node_modules/jest/bin/jest.js"
end

local function run_jest(args, config)
	local t = {}
	table.insert(t, config.cmd)
	if args ~= nil then
		for _, v in pairs(args) do
			table.insert(t, v)
		end
	end
	local cmd = table.concat(t, "")
	local command = string.format('1TermExec cmd="%s"', cmd)
	vim.cmd(command)
end

M.get_local_jest = get_local_jest

M.run_jest = run_jest

M.run = function(args, c_file, config)
	table.insert(args, " -- --runTestsByPath " .. c_file)
	table.insert(args, " --watch")
	run_jest(args, config)
end

M.integration_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "npm run test:integration"
	M.run(args, c_file, config)
end

M.unit_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "npm run test:unit"
	M.run(args, c_file, config)
end

M.benchmark_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "npm run test:unit"
	M.run(args, c_file, config)
end

return M
