local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
  keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true })
end

M.filetypes = {
  "templ",
  "tsx",
  "jsx",
}

M.init_options = {
  userLanguages = {
    templ = "html",
  },
}

return M
