local M = {}

---Generate unique session ID
---@return string
function M.generate_session_id()
	return vim.fn.strftime("%Y%m%d_%H%M%S") .. "_" .. vim.fn.rand()
end

---Generate terminal name for session
---@param session_id string
---@return string
function M.generate_terminal_name(session_id)
	return "chat_" .. session_id
end

---Format message for terminal display
---@param role string
---@param content string
---@return string
function M.format_message_for_terminal(role, content)
	return string.format("[%s] %s: %s", 
		os.date("%H:%M:%S"), 
		role == "user" and "You" or "Assistant", 
		content
	)
end

---Check if session exists
---@param session_id string
---@return boolean
function M.session_exists(session_id)
	local sessions = require("ai.chat.shared.storage").get_sessions()
	return sessions[session_id] ~= nil
end

return M