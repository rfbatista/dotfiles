return {
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
      version = "1.31.0",
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
          go = {},
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
    servers = {},
    setup = {},
  },
}
