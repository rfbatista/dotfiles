return {
  {
    "ray-x/go.nvim",
    enable = false,
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",

      "leoluz/nvim-dap-go",
    },
    config = function()
      local capabilities = require("config.gopls").capabilities

      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
      require("lspconfig").gopls.setup(require("config.gopls"))

      require("go").setup({
        capabilities = capabilities,
        lsp_on_attach = require("config.lsp.keymap").on_attach,
        lsp_cfg = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        luasnip = true,
      })
      require("lspconfig").templ.setup(require("config.templ"))
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- [[ build = ':lua require("go.install").update_all_sync()', ]]
  },
}
