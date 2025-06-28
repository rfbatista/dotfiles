return {
  "mistweaverco/kulala.nvim",
  -- "rest-nvim/rest.nvim",
  tag = "v5.3.1",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "nvim-neotest/nvim-nio",
  },
  opts = {
    display_mode = "split",
    icons = {
      inlay = {
        loading = "",
        done = "󰸞",
        error = "",
      },
      lualine = "",
    },
  },

  -- opts = function(_, opts)
  --   opts.ensure_installed = opts.ensure_installed or {}
  --   table.insert(opts.ensure_installed, "http")
  -- end,
}
