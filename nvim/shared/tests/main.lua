local go_tests = require("tests.golang")
local node_tests = require("tests.node")

local M = {}

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

function M.integration_test()
	local type = vim.bo.filetype
	if type == "go" then
		return go_tests.integration_test()
	end
	return node_tests.integration_test()
end

return M
