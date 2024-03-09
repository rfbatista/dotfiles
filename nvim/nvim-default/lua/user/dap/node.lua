local M = {}

function M.setup()
  local dap = require("dap")
  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

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
      type = "node2",
      request = "attach",
      name = "Attach Program (Node2 with ts-node)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
    },
  }
end

return M
