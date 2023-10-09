-- Base
require "user.keymaps"
require "user.plugins"
require "user.options"

require "user.dap.nvim-dap".setup()

-- Interface
require "user.interface.theme"
require "user.interface.lualine"
require "user.interface.nvim-tree"
require "user.interface.bufferline"
require "user.interface.alpha"
require "user.interface.dressing"
require "user.interface.tagbar"
require "user.interface.gitsigns"
require "user.interface.indentline"
require "user.interface.telescope-config"
require "user.interface.toggleterm"
require "user.interface.trouble"
require "user.interface.mvllow"

-- Commands
require "user.commands.autocommands"
require "user.commands.autopairs"
require "user.commands.cinnamon"
require "user.commands.comment"
require "user.commands.vim-sneak"
require "user.commands.whichkey"
require "user.commands.harpoon"

-- Languages
require "user.languages.init"

-- Others
require "user.others.project"
require "user.others.impatient"
require "user.others.numb"
require "user.others.filetype"
