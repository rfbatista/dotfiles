return {
  "olexsmir/gopher.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("gopher").setup({
      commands = {
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests", -- also you can set custom command path
        impl = "impl",
        iferr = "iferr",
      },
    })
  end,
}
