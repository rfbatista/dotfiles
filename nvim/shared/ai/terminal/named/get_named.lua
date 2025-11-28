local M = {}

local storage = require("ai.terminal.shared.storage")

---Get a named terminal
---@param name string Name of the terminal
---@return snacks.win?
function M.get_named(name)
	local term_info = storage.get_named_terminal_info(name)
	if term_info then
		return term_info.term
	end
	return nil
end

return M