vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.loader.enable()

vim.cmd([[
  set nofoldenable
]])

-- Base
require("user.languages.lsp.handlers").setup()
require("user.keymaps")
require("user.autocommands")
require("user.lazy")
require("user.filetype")
require("user.options")
