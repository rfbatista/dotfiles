local home_dir = os.getenv("HOME")
package.path = home_dir .. "/dotfiles/nvim/shared/?.lua;" .. package.path

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.loader.enable()

vim.cmd([[
  set nofoldenable
]])

require("languages.lsp.handlers").setup()
require("autocommands")
require("options")
require("keymaps")
require("icons")
require("deps")
require("keygroups")
