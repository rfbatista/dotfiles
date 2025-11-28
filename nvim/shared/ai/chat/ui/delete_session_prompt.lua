local M = {}

local storage = require("ai.chat.shared.storage")
local delete_session = require("ai.chat.core.delete_session")
local show_session_picker = require("ai.chat.ui.show_session_picker")

---Delete specific session with confirmation
---@param session_id string
function M.delete_session_prompt(session_id)
	local sessions = storage.get_sessions()
	local session = sessions[session_id]
	if not session then
		vim.notify("Session not found", vim.log.levels.ERROR)
		return
	end
	
	vim.ui.input({
		prompt = string.format("Delete session '%s'? Type 'yes' to confirm: ", session.name),
		default = "",
	}, function(confirmation)
		if confirmation and confirmation:lower() == "yes" then
			delete_session.delete_session(session_id)
			-- Refresh the picker after deletion
			show_session_picker.show_session_picker()
		else
			vim.notify("Session deletion cancelled", vim.log.levels.INFO)
		end
	end)
end

return M