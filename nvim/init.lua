-- Base
require("user.keymaps")
require("user.plugins")
require("user.options")

require("user.dap.nvim-dap").setup()

-- Languages
require("user.languages.init")

-- Interface
require("user.interface.lualine")
require("user.interface.nvim-tree")
require("user.interface.bufferline")
require("user.interface.alpha")
require("user.interface.dressing")
require("user.interface.tagbar")
require("user.interface.gitsigns")
require("user.interface.indentline")
require("user.interface.telescope-config")
require("user.interface.toggleterm")
require("user.interface.trouble")
require("user.interface.mvllow")
require("user.interface.notify")
require("user.interface.highlight-color")

-- Commands
require("user.commands.autocommands")
require("user.commands.autopairs")
require("user.commands.cinnamon")
require("user.commands.comment")
require("user.commands.vim-sneak")
require("user.commands.whichkey")
require("user.commands.harpoon")
require("user.commands.folding")

-- Others
require("user.others.project")
require("user.others.impatient")
require("user.others.numb")
require("user.others.filetype")

-- Theme
require("user.theme")
