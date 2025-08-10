local keymap = require("config.lsp.keymap")

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

local M = {}

M.on_attach = function(client, bufnr)
  keymap.on_attach(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
