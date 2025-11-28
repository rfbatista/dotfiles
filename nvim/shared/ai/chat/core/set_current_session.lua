local M = {}

local storage = require("ai.chat.shared.storage")
local persistence = require("ai.chat.shared.persistence")
local terminal = require("ai.terminal")

---Set current session
---@param session_id string
---@return boolean
function M.set_current_session(session_id)
	local sessions = storage.get_sessions()
	if sessions[session_id] then
		local session = sessions[session_id]
		storage.set_current_session_id(session_id)
		
		-- Open associated terminal and set as active
		if session.terminal_name then
			terminal.toggle_named(session.terminal_name)
			terminal.set_active_terminal(session.terminal_name)
		end
		
		persistence.save_sessions()
		vim.notify("Switched to session: " .. session.name, vim.log.levels.INFO)
		return true
	end
	return false
end

return M