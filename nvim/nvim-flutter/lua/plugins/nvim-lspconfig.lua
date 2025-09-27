return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        debugger = {
          -- make these two params true to enable debug mode
          enabled = false,
          run_via_dap = false,
          register_configurations = function(_)
            require("dap").adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" },
            }

            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = "home/flutter/bin/cache/dart-sdk/",
                flutterSdkPath = "home/flutter",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }
            -- uncomment below line if you've launch.json file already in your vscode setup
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        dev_log = {
          -- toggle it when you run without DAP
          enabled = false,
          open_cmd = "tabedit",
        },
        lsp = {
          on_attach = require("lvim.lsp").common_on_attach,
          capabilities = require("lvim.lsp").default_capabilities,
        },
      })
    end,
  },
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
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gr", "<cmd>lua vim.lsp.buf.rename()<cr>" }
    end,
  },
}
