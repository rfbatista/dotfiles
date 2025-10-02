return {

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    enabled = false,
    opts = {},
  },
  {
    "yioneko/nvim-vtsls",
    commit = "0b5f73c9e50ce95842ea07bb3f05c7d66d87d14a",
  },
  {
    -- Core LSP and Mason
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        tag = "v1.11.0",
        version = "^1.0.0",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
          table.insert(opts.ensure_installed, "prettier")
        end,
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
        tag = "v1.32.0",
        version = "^1.0.0",
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
          {
            "leoluz/nvim-dap-go",
            opts = {},
          },
        },
      },
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = true,
      })
    end,
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>" }
    end,
  },
  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
