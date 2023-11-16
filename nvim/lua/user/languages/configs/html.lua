local base = require("user.languages.lsp.keymap")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {}

M.on_attach = base.on_attach

M.capabilities = capabilities

M.filetypes = { "html" }

return M
