return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local which_key = require("which-key")
    which_key.setup({})
  end,
}
