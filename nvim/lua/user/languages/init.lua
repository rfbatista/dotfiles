local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.languages.lsp"
require "user.languages.configs.cmake"
require "user.languages.configs.jester"
require "user.languages.cmp"
require "user.languages.prettier"
require "user.languages.treesitter"
