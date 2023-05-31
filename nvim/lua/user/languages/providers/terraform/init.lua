local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = keymap.on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

M.flags = { debounce_text_changes = 150 }

M.filetypes = { "tf" }

return M
