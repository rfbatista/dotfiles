local home_dir = os.getenv("HOME")
package.path = home_dir .. "/dotfiles/nvim/shared/?.lua;" .. package.path
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.loader.enable()

vim.cmd([[
  set nofoldenable
]])

vim.filetype.add {
  extension = {
    jinja = 'jinja.html',
    jinja2 = 'jinja.html',
    j2 = 'jinja.html',
  },
}

-- Base
require("languages.lsp.handlers").setup()
require("user.keymaps")
require("user.autocommands")
require("user.lazy")
require("user.filetype")
require("user.options")
require("user.helpers")
