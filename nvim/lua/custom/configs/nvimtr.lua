local M = {}
  -- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local tree_cb = {}
  
M.setup = {
  disable_netrw = true,
  auto_reload_on_write = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  view = {
    width = 60,
    hide_root_folder = false,
    side = "right",
    mappings = {
      custom_only = false,
      -- list = {
      --   { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      --   { key = "h", cb = tree_cb "close_node" },
      --   { key = "v", cb = tree_cb "vsplit" },
      --   { key = "<C-n>", cb = tree_cb "create" },
        -- },
    },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
}

return M
