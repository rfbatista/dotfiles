local keymap = require("user.languages.lsp.keymap")

local M = {}

--[[ M.cmd = { '/home/renan/dotfiles/lsp/lua-language-server' } ]]

M.on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  keymap.on_attach(client, bufnr)
end

M.settings = {
  Lua = {
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
  },
}

return M
