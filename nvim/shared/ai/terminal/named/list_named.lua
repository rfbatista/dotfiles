local M = {}

local storage = require("ai.terminal.shared.storage")
local utils = require("ai.terminal.shared.utils")

---List all named terminals
---@return table List of terminal names and info
function M.list_named()
	local list = {}
	local named_terminals = storage.get_named_terminals()
	
	for name, info in pairs(named_terminals) do
		local is_valid = utils.is_terminal_valid(info.term)
		table.insert(list, {
			name = name,
			cmd = info.cmd,
			valid = is_valid,
			created_at = info.created_at,
		})
	end
	return list
end

return M