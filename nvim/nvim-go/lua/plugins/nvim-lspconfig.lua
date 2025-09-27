local base = require("languages.lsp.keymap")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
return {
  -- Core LSP and Mason
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = { ensure_installed = { "goimports", "gofumpt", "gomodifytags", "impl", "delve", "prettier", "bicep" } },
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
      version = "1.31.0",
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
      bicep = {
        filetypes = { "bicep" },
        -- cmd = { "~/.local/share/nvim-go/mason/bin/bicep-lsp" },
        cmd = { vim.fn.expand("~/.local/share/nvim-go/mason/bin/bicep-lsp") },
        -- cmd = {
        --   "dotnet",
        --   "~/.azure/bin/bicep",
        -- },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.signatureHelpProvider = false
          base.on_attach(client, bufnr)
        end,
      },
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectories = { mode = "auto" },
        },
      },
    },
    setup = {
      eslint = function()
        local function get_client(buf)
          return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
        end

        local formatter = LazyVim.lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })

        -- Use EslintFixAll on Neovim < 0.10.0
        if not pcall(require, "vim.lsp._dynamic") then
          formatter.name = "eslint: EslintFixAll"
          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "eslint" } or {}
          end
          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
              if #diag > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end
        end

        -- register the formatter with LazyVim
        LazyVim.format.register(formatter)
      end,
    },
  },
}
