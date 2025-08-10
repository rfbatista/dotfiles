return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Git Signs",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>uG")
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
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<A-a>",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<A-s>",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }
      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
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
  {
    "rcarriga/nvim-notify",
    tag = "v3.15.0",
    config = function()
      local nvim_notify = require("notify")
      nvim_notify.setup({
        background_colour = "#000000",
      })
    end,
  },
}
