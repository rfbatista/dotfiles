local plugins = {
  {
    "NvChad/nvterm",
    config = function()
      require "custom.configs.nvterm"
    end,
  },
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html", "css", "bash", "lua" },
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      require "custom.configs.whichkey"
    end,
  },
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lsp"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("custom.configs.nvimtr").setup,
  },
}

return plugins
