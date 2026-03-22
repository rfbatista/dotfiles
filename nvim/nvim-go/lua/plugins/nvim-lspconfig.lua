return {
  { "fatih/vim-go" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      {
        "nvim-treesitter/nvim-treesitter", -- Optional, but recommended
        branch = "main",                   -- NOTE; not the master branch!
        build = function()
          vim.cmd(":TSUpdate go")
        end,
      },
      {
        "fredrikaverpil/neotest-golang",
        version = "*",                                                            -- Optional, but recommended; track releases
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
      },
    },
    config = function()
      local config = {
        runner = "gotestsum", -- Optional, but recommended
      }
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(config),
        },
      })
    end,
  },
  {
    -- Core LSP and Mason
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = { "goimports", "gofumpt", "gomodifytags", "impl", "delve", "prettier", "bicep", "dlv" },
        },
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
        "carlsmedstad/vim-bicep",
        commit = "8172cf773d52302d6c9d663487f56630302b2fda",
      },
      {
        "mason-org/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "gopls" },
          })
        end,
      },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
          formatters_by_ft = {
            go = { "goimports", "gofumpt" },
            ["html"] = { "prettier" },
          },
        },
      },
      {
        "mfussenegger/nvim-lint",
        event = "LazyFile",
      },
    },
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>" },
            { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
          },
        },
      },
    },
  },
}
