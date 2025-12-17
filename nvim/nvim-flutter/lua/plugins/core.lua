return {
  {
    "LazyVim/LazyVim",
    depends = {
      {
        "catppuccin/nvim",
        tag = "v1.11.0",
        priority = 1000,
        name = "catppuccin",
      },
    },
    opts = {
      defaults = {
        keymaps = false,
      },
      colorscheme = function()
        require("catppuccin").setup({
          float = {
            transparent = false,
            solid = true,
          },
          flavour = "mocha",
          background = {
            light = "latte",
            dark = "mocha",
          },
          transparent_background = true, -- disables setting the background color.
          integrations = {
            aerial = true,
            fzf = true,
            gitsigns = {
              enabled = true,
              transparent = true,
            },
            harpoon = true,
            leap = true,
            mason = true,
            dap = true,
            dap_ui = true,
            neotree = true,
          },
        })
        require("catppuccin").load()
        -- vim.api.nvim_command("colorscheme catppuccin")
      end,
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       -- floats = "transparent",
  --     },
  --   },
  -- },
}
