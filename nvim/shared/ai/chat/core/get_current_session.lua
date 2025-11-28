local M = {}

local storage = require("ai.chat.shared.storage")

---Get current session
---@return table?
function M.get_current_session()
	local current_session_id = storage.get_current_session_id()
	if current_session_id then
		return storage.get_session(current_session_id)
	end
	return nil
end

return M