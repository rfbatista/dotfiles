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
      colorscheme = function()
        require("catppuccin").setup({
          flavour = "mocha",
          background = {
            light = "latte",
            dark = "mocha",
          },
          transparent_background = true, -- disables setting the background color.
        })
        require("catppuccin").load()
        -- vim.api.nvim_command("colorscheme catppuccin")
      end,
    },
  },
}
