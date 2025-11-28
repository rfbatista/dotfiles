local M = {}

local storage = require("ai.terminal.shared.storage")

---Set active terminal
---@param name string Name of the terminal to set as active
---@return boolean Success status
function M.set_active_terminal(name)
	local named_terminals = storage.get_named_terminals()
	if named_terminals[name] then
		storage.set_active_terminal_name(name)
		vim.notify("Set active terminal: " .. name, vim.log.levels.INFO)
		return true
	end
	return false
end

return M