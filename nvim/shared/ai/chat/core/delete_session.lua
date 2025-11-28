local M = {}

local storage = require("ai.chat.shared.storage")
local persistence = require("ai.chat.shared.persistence")
local terminal = require("ai.terminal")

---Delete a chat session
---@param session_id string
---@return boolean
function M.delete_session(session_id)
	local sessions = storage.get_sessions()
	if sessions[session_id] then
		local session = sessions[session_id]
		local session_name = session.name
		
		-- Delete associated terminal
		if session.terminal_name then
			terminal.delete_named(session.terminal_name)
		end
		
		storage.remove_session(session_id)
		
		-- If we deleted the current session, set current to nil
		if storage.get_current_session_id() == session_id then
			storage.set_current_session_id(nil)
		end
		
		persistence.save_sessions()
		vim.notify("Deleted session: " .. session_name, vim.log.levels.INFO)
		return true
	end
	return false
end

return M