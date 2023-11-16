local status_ok = pcall(require, "which-key")
if not status_ok then
	return
end

local go_tests = require("user.languages.tests.golang")
local node_tests = require("user.languages.tests.node")

function Unit_test()
	local type = vim.bo.filetype
	if type == "go" then
		return go_tests.unit_test()
	end
	return node_tests.unit_test()
end

function Benchmark_test()
	local type = vim.bo.filetype
	if type == "go" then
		return go_tests.benchmark_test()
	end
	return node_tests.benchmark_test()
end

function Integration_test()
	local type = vim.bo.filetype
	if type == "go" then
		return go_tests.integration_test()
	end
	return node_tests.integration_test()
end

local M = {
	keymap = {
		name = "Tests",
		a = { "<cmd>lua Unit_test()<cr>", "Run current unit test file" },
		b = { "<cmd>lua Benchmark_test()<cr>", "Run benchmark test" },
		i = { "<cmd>lua Integration_test()<cr>", "Run current integration test file" },
	},
}

return M
