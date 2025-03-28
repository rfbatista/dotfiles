return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbar").setup({
      animation = false,
      auto_hide = false,
    })
  end,
}
