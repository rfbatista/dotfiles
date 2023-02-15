local keymap = require("user.languages.lsp.keymap")
local M = {}

M.on_attach = keymap.on_attach

M.filetypes = { "yaml" }

M.settings = {
	ansible = {
		ansible = {
			path = "ansible",
		},
		ansibleLint = {
			enabled = true,
			path = "ansible-lint",
		},
		executionEnvironment = {
			enabled = false,
		},
		python = {
			interpreterPath = "python",
		},
	},
}

return M
