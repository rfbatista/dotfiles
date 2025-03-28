local base = require("user.languages.lsp.keymap")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {}

M.on_attach = base.on_attach

M.on_attach = function(client, bufnr)
  client.server_capabilities.signatureHelpProvider = false
  base.on_attach(client, bufnr)
end

M.capabilities = capabilities

return M
