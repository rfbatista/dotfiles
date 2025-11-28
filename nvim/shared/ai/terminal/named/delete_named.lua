local M = {}

local storage = require("ai.terminal.shared.storage")
local utils = require("ai.terminal.shared.utils")

---Delete a named terminal
---@param name string Name of the terminal
---@return boolean Success status
function M.delete_named(name)
	local named_terminals = storage.get_named_terminals()
	if named_terminals[name] then
		local term = named_terminals[name].term
		if utils.is_terminal_valid(term) then
			vim.api.nvim_buf_delete(term.buf, { force = true })
		end
		storage.remove_named_terminal(name)
		-- Clear active if this was the active terminal
		if storage.get_active_terminal_name() == name then
			storage.set_active_terminal_name(nil)
		end
		vim.notify("Deleted named terminal: " .. name, vim.log.levels.INFO)
		return true
	end
	return false
end

return M