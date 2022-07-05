local keymap = require("user.languages.lsp.keymap")
local M = {}

M.capabilities = require("user.languages.lsp.capabilities").capabilities

M.on_attach = keymap.on_attach

M.settings = {
	json = {
		schemas = {
			{
				fileMatch = { "package.json" },
				url = "https://json.schemastore.org/package.json",
			},
			{
				fileMatch = { "tsconfig.json", "tsconfig.*.json" },
				url = "http://json.schemastore.org/tsconfig",
			},
			{
				fileMatch = { ".eslintrc.json", ".eslintrc" },
				url = "http://json.schemastore.org/eslintrc",
			},
			{
				fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
				url = "http://json.schemastore.org/prettierrc",
			},
			{
				fileMatch = { "deno.json" },
				url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json",
			},
		},
	},
}

return M
