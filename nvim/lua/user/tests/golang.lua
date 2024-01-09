local helper = require("user.tests.helper")

local M = {}

local function findTestName()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local current_node = ts_utils.get_node_at_cursor()
	local expr = current_node
	while expr do
		if expr:type() == "function_definition" or expr:type() == "function_declaration" then
			return (ts_utils.get_node_text(expr:child(1)))[1]
		end
		expr = expr:parent()
	end
	if not expr then
		return ""
	end
	return (ts_utils.get_node_text(expr:child(1)))[1]
end

local function run_gotest(args, config)
	local t = {}
	table.insert(t, config.cmd)
	if args ~= nil then
		for _, v in pairs(args) do
			table.insert(t, v)
		end
	end
	local cmd = table.concat(t, "")
	local command = string.format('1TermExec cmd="%s"', cmd)
	vim.cmd(command)
end

M.run_gotest = run_gotest

M.run = function(args, config)
	run_gotest(args, config)
end

M.findTestName = findTestName

M.unit_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "go test"
	local testName = findTestName()
	local rootPath = helper.find_project_root()
	local start_idx, end_idx = c_file:find(rootPath)
	local after = c_file:sub(end_idx + 1)
	local gotestargs = " ." .. after:match(".*/")
	table.insert(args, gotestargs)
	M.run(args, config)
end

M.integration_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "go test"
	M.run(args, config)
end

M.benchmark_test = function()
	local config = {}
	local c_file = helper.get_current_file_path()
	local args = {}
	config.cmd = "go test -bench=."
	local testName = findTestName()
	local rootPath = helper.find_project_root()
	local start_idx, end_idx = c_file:find(rootPath)
	local after = c_file:sub(end_idx + 1)
	local gotestargs = " ." .. after:match(".*/")
	table.insert(args, gotestargs)
	print(gotestargs)
	M.run(args, config)
end

return M
