local M = {}

local storage = require("ai.chat.shared.storage")

---Get all sessions
---@return table
function M.get_sessions()
	return storage.get_sessions()
end

return M