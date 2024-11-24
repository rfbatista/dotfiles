return {
  "mfussenegger/nvim-dap",
  event = "BufRead",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("dap-vscode-js").setup({
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          -- debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            "chrome",
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "pwa-extensionHost",
            "node-terminal",
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

          -- Logging level for output to file. Set to false to disable logging.
          -- log_file_level = false,

          -- Logging level for output to console. Set to false to disable console output.
          -- log_console_level = vim.log.levels.ERROR,
        })
      end,
    },
  },
  config = function()
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = require("user.icons").ui.Circle, texthl = "", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = require("user.icons").ui.BoldClose, texthl = "", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = require("user.icons").ui.ArrowCircleRight, texthl = "", linehl = "", numhl = "" }
    )
    require("mason").setup()
    require("mason-nvim-dap").setup({
      handlers = {
        node2 = function(config)
          config.adapters = {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            -- cwd = vim.fn.getcwd(),
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })
    local dap = require("dap")
    local dapui = require("dapui")
    local virtual_text = require("nvim-dap-virtual-text")
    local dap_go = require("dap-go")

    dap.adapters.lldb = {
      type = "executable",
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    }

    local lldb = {
      name = "Launch lldb",
      type = "lldb",   -- matches the adapter
      request = "launch", -- could also attach to a currently running process
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    }

    dap.configurations.rust = {
      lldb,
    }

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- for name, sign in pairs(Config.icons.dap) do
    --   sign = type(sign) == "table" and sign or { sign }
    --   vim.fn.sign_define(
    --     "Dap" .. name,
    --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --   )
    -- end

    local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
    dap.adapters.node2 = {
      type = "executable",
      command = "node-debug2-adapter",
      -- args = { mason_path .. "package/node-debug2-adapter/out/src/nodeDebug.js" },
    }
    dapui.setup()
    virtual_text.setup()
    dap_go.setup()
  end,
}
