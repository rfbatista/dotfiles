local M = {}

local get_current_session = require("ai.chat.core.get_current_session")

---Get messages from current session
---@return table
function M.get_messages()
	local session = get_current_session.get_current_session()
	if session then
		return session.messages
	end
	return {}
end

return M