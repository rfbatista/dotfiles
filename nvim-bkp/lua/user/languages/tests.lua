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

local M = {
	keymap = {
		name = "Tests",
		a = {
			[[<cmd>lua require'jester'.run({path_to_jest_run = './node_modules/jest/bin/jest.js'})<cr>]],
			"Run test under cursor",
		},
		b = { "<cmd>lua require'jester'.debug(_JESTER_DEBUG())<cr>", "[DEBUG] Run test under cursor" },
		c = { "<cmd>lua require'jester'.run_file()<cr>", "Run current test file" },
		d = { "<cmd>lua require'jester'.debug_file()<cr>", "[DEBUG] Run current test file" },
	},
}

return M
