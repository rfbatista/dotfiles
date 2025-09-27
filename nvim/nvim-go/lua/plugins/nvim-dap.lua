return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
      {
        "yriveiro/dap-go.nvim",
        ft = "go",
        requires = { "nvim-lua/plenary.nvim" },
      },
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- dependency for nvim-dap-ui
      "theHamsta/nvim-dap-virtual-text",
    },
    opts = function()
      -- Simple configuration to attach to remote java debug process
      -- Taken directly from https://github.com/mfussenegger/nvim-dap/wiki/Java
    end,
    config = function()
      require("dapui").setup()
      vim.fn.sign_define("DapBreakpoint", { text = require("icons").ui.Circle, texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = require("icons").ui.BoldClose, texthl = "", linehl = "", numhl = "" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = require("icons").ui.ArrowCircleRight, texthl = "", linehl = "", numhl = "" }
      )
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      local dap = require("dap")

      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
            port = 38697,
            host = "127.0.0.1",
          },
        },
      })
    end,
  },
}
