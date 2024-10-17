local keymap = require("user.languages.lsp.keymap")

local M = {}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr)
end

M.capabilities = capabilities

M.settings = {
	css = {
		lint = {
			unknownAtRules = "ignore",
		},
	},
}

return M
