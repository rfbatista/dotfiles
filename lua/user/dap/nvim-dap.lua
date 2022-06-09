local M = {}

function M.nvim_dap_setup()
  -- DAPInstall
  require("user.dap.which-key").setup()
  local dap_install = require("dap-install")
  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  -- telescope-dap
  require("telescope").load_extension "dap"

  -- nvim-dap-virtual-text. Show virtual text for current frame
  -- vim.g.dap_virtual_text = true -- deprecated

  -- nvim-dap-ui
  require("dapui").setup {}

  -- languages
  require("user.dap.python")
  require("user.dap.node").setup()

  -- nvim-dap
  vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

  vim.g.vimspector_enable_mappings = ""
end

function M.setup()
  M.nvim_dap_setup()
end

return M
