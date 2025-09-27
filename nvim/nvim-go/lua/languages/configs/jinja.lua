local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
	keymap.on_attach(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.filetypes = { "jinja", "jinja.html" }

return M
