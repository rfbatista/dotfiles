local M = {}

function M.nvim_dap_setup() -- DAPInstall: lua
  require("dap").set_log_level("DEBUG")

  require("user.dap.dap-keys").setup()
  local dap_install = require("dap-install")
  dap_install.setup({
    installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
  })
  --[[ dap_install.config("jsnode", { ]]
  --[[ 	adapters = { ]]
  --[[ 		type = "executable", ]]
  --[[ 		command = "node", ]]
  --[[ 		args = { ]]
  --[[ 			vim.fn.stdpath("data") .. "/dapinstall/jsnode/vscode-node-debug2/out/src/nodeDebug.js", ]]
  --[[ 		}, ]]
  --[[ 	}, ]]
  --[[ 	configurations = { ]]
  --[[ 		{ ]]
  --[[ 			type = "node2", ]]
  --[[ 			request = "launch", ]]
  --[[ 			program = "${workspaceFolder}/${file}", ]]
  --[[ 			cwd = vim.fn.getcwd(), ]]
  --[[ 			sourceMaps = true, ]]
  --[[ 			protocol = "inspector", ]]
  --[[ 			console = "integratedTerminal", ]]
  --[[ 		}, ]]
  --[[ 	}, ]]
  --[[ }) ]]
  --[[ dap_install.config("go", {}) ]]

  -- telescope-dap
  require("telescope").load_extension("dap")

  -- nvim-dap-virtual-text. Show virtual text for current frame
  -- vim.g.dap_virtual_text = true -- deprecated

  -- nvim-dap-ui
  require("dapui").setup({})

  -- languages
  --[[ require("user.dap.python") ]]
  require("user.dap.node").setup()

  -- nvim-dap
  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

  vim.g.vimspector_enable_mappings = ""
  require("dap-go").setup()
end

function M.setup()
  M.nvim_dap_setup()
end

return M
