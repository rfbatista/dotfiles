return {
	"mfussenegger/nvim-dap",
	event = "BufRead",
	lazy = true,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
		"folke/neodev.nvim",
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			-- After install, build it and rename the dist directory to out
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
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
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		local dap = require("dap")
		require("nvim-dap-virtual-text").setup()

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})
		dap.configurations.javascript = {
			{
				type = "pwa-node",
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
				type = "pwa-node",
				request = "attach",
				name = "Attach Program (Node2 with ts-node)",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				port = 9229,
			},
		}
		require("dapui").setup({})
    require('dap-go').setup()
	end,
}
