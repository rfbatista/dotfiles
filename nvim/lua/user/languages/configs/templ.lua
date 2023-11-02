local keymap = require("user.languages.lsp.keymap")

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

local M = {}

M.on_attach = function(client, bufnr)
  keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true })
end

return M
