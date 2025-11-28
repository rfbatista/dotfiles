local M = {}

local storage = require("ai.terminal.shared.storage")

---Get active terminal name
---@return string? Active terminal name
function M.get_active_terminal()
	return storage.get_active_terminal_name()
end

return M