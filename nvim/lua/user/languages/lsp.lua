local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

vim.lsp.set_log_level("debug")

require("user.languages.lsp.installer")
require("user.languages.lsp.configs")
require("user.languages.lsp.handlers").setup()
require "user.languages.lsp.null-ls"
require "user.languages.lsp.signature"
