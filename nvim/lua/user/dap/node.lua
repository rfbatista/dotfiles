local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv('HOME') .. '/dotfiles/vscode-node-debug2/out/src/nodeDebug.js' },
  }

  dap.configurations.javascript = {
    {
      type = "node2",
      request = "launch",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
  }

  dap.configurations.typescript = {
    {
      type = 'node2',
      runtimeArgs = {
        'run-script',
        'dev'
      },
      runtimeExecutable = 'npm',
      skipFiles = { '<node_internals>/**'
      },
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      outFiles = { "${workspaceFolder}/**/*.js",
        "!**/node_modules/**"
      },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
  }
end

return M
