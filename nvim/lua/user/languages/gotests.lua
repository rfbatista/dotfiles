local M = {}

M.findTestName = function()
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

return M
