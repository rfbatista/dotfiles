return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "catppuccin/nvim",
    tag = "v1.11.0",
    priority = 1000,
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
  {
    "ggandor/leap.nvim",
    dependencies = { { "tpope/vim-repeat" } },
    config = function()
      require("leap").init_highlight(true)
    end,
  },
  {
    "folke/snacks.nvim",
  },
  {
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
  },
  { "nvim-neotest/nvim-nio" },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },
  { "echasnovski/mini.nvim", version = "*" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    tag = "v0.0.10",
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      --Remap space as leader key
      keymap("", "<Space>", "<Nop>", opts)
      -- Harpoon
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
      })
      keymap("n", "<A-a>", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
      keymap("n", "<A-c>", "<cmd>lua require('harpoon.mark').clear()<cr>", opts)
      keymap("n", "<A-s>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "famiu/bufdelete.nvim",
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end,
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("barbar").setup({
        animation = false,
        auto_hide = false,
      })
    end,
  },
  { "tpope/vim-surround", tag = "v2.2" },
}
