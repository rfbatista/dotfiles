return {
  {
    "dart-lang/dart-vim-plugin",
  },
  {
    -- Core LSP and Mason
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = {} },
        config = function()
          require("mason").setup({
            ui = {
              border = "rounded",
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
              },
            },
          })
        end,
      },
      {
        "mason-org/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = {},
          })
        end,
      },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
          formatters_by_ft = {
            dart = { "dart_format" },
          },
        },
      },
      {
        "sidlatau/neotest-dart",
      },
      {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
          "sidlatau/neotest-dart",
        },
        opts = {
          adapters = {
            ["neotest-dart"] = {},
          },
        },
      },
      {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
          {
            "mason-org/mason.nvim",
            opts = { ensure_installed = {} },
          },
        },
      },
    },
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gR", "<cmd>lua vim.lsp.buf.rename()<cr>" },
            -- { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
          },
        },
      },
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({})
    end,
  },
}
