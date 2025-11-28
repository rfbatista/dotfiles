local M = {}

-- Session storage
local sessions = {}
local current_session = nil
local sessions_file = vim.fn.stdpath("data") .. "/chat_sessions.json"

---Get sessions storage
---@return table
function M.get_sessions()
	return sessions
end

---Set sessions storage
---@param new_sessions table
function M.set_sessions(new_sessions)
	sessions = new_sessions
end

---Get current session ID
---@return string?
function M.get_current_session_id()
	return current_session
end

---Set current session ID
---@param session_id string?
function M.set_current_session_id(session_id)
	current_session = session_id
end

---Get sessions file path
---@return string
function M.get_sessions_file()
	return sessions_file
end

---Add session to storage
---@param session_id string
---@param session table
function M.add_session(session_id, session)
	sessions[session_id] = session
end

---Remove session from storage
---@param session_id string
function M.remove_session(session_id)
	sessions[session_id] = nil
end

---Get session by ID
---@param session_id string
---@return table?
function M.get_session(session_id)
	return sessions[session_id]
end

return M