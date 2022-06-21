local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.languages.lsp.installer")
require("user.languages.lsp.configs")
require("user.languages.lsp.handlers").setup()
require "user.languages.lsp.null-ls"
