return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/prettier.nvim",
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
    local servers = {
      "pyright",
      "jsonls",
      "lua_ls",
      "gopls",
      "clangd",
      "tsserver",
      "kotlin_language_server",
      "terraformls",
      "dockerls",
      "templ",
      "htmx",
      "tailwindcss",
      "cssls",
      "rust_analyzer",
      "sqls",
      "terraformls",
      "hcl",
    }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    require("mason-lspconfig").setup_handlers({
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup(require("languages.configs.sumneko"))
      end,
      -- ["gopls"] = function()
      --   require("lspconfig").gopls.setup(require("languages.configs.gopls"))
      -- end,
    })

    vim.diagnostic.config({
      title = false,
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        source = "always",
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
      },
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local mason_null_ls = require("mason-null-ls")
    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")

    mason_null_ls.setup({
      ensure_installed = {
        "prettier",       -- prettier formatter
        "stylua",         -- lua formatter
        "eslint_d",       -- js linter
        "golangci_lint",  -- go linter
        "terraform_fmt",  -- terraform formatter
        "terraform_validate", -- terraform linter
        "shellcheck",     -- shell linter
        "buf",            -- buf formatter
        "gofumpt",        -- go formatter "gofmt",
        "golines",
        "goimports_reviser",
        "yamlfmt", -- yaml formatter
        "goimports",
        "spell", -- spell checker
        "black",
        "blackd",
        "pylint",
        "golangci_lint",
      },
    })

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),

      sources = {
        formatting.gofumpt,
        formatting.terraform_fmt,
        formatting.buf,
        formatting.yamlfmt,
        formatting.goimports,
        formatting.golines,
        formatting.goimports_reviser,
        formatting.sql_formatter,
        -- diagnostics.golangci_lint,
        diagnostics.terraform_validate,
        diagnostics.yamllint,
        diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" }, -- change to your dialect
        }),
        code_actions.gitsigns,
        code_actions.refactoring,
      },
    })
  end,
}
