return {
  "romgrk/barbar.nvim",
  config = function()
    require("barbar").setup({
      animation = false,
      auto_hide = false,
    })
  end,
}
