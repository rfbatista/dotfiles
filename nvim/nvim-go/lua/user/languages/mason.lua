return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
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
      "gopls",
      "gofumpt",
      "goimports",
      "goimports-revisers",
      "golines",
      "gomodifytags",
      "templ",
      "gotests",
      "impl",
    }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })
    local navic = require("nvim-navic")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    local util = require("lspconfig/util")
    require("mason-lspconfig").setup_handlers({
      ["gopls"] = function()
        require("lspconfig").gopls.setup({
          on_attach = require("user.lsp.on_attach").on_attach,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          capabilities = capabilities,
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        })
      end,
    })
  end,
}
