local keymap = require("user.languages.lsp.keymap")

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

local M = {}

M.on_attach = function(client, bufnr)
  --[[ keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true }) ]]
  keymap.on_attach(client, bufnr)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
