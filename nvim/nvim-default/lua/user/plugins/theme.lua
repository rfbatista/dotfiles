return {
  {
    "catppuccin/nvim",
    priority = 150,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
      })
      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
}
