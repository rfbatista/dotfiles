local function attach()
	local dap = require("dap")
	print("attaching")
  dap.set_log_level('TRACE')
	dap.run({
		type = "node2",
		request = "attach",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
	})
end

local function ts_node()
	local dap = require("dap")
	print("Launching ts-node")
	dap.run({
		name = "TS-NODE debug configuration",
		type = "node2",
		request = "launch",
		runtimeArgs = { "-r", "ts-node/register" },
		args = { "${workspaceFolder}/index.ts" },
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		skipFiles = { "<node_internals>/**/*.js" },
	})
end

return {
	attach = attach,
	ts_node = ts_node,
}
