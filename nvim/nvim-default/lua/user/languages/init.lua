local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

--[[ vim.lsp.set_log_level("info") ]]

require("user.languages.lsp.handlers").setup()
require "user.languages.lsp.null-ls"
require "user.languages.lsp.signature"
require("user.languages.installer")


--require "user.languages.configs.cmake"
--require "user.languages.configs.jester"
require "user.languages.cmp"
require "user.languages.prettier"
require "user.languages.treesitter"
