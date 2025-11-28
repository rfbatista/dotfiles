local M = {}

local get_current_session = require("ai.chat.core.get_current_session")
local delete_session = require("ai.chat.core.delete_session")

---Delete current session with confirmation
function M.delete_current_session_prompt()
	local session = get_current_session.get_current_session()
	if not session then
		vim.notify("No current session to delete", vim.log.levels.WARN)
		return
	end
	
	vim.ui.input({
		prompt = string.format("Delete session '%s'? Type 'yes' to confirm: ", session.name),
		default = "",
	}, function(confirmation)
		if confirmation and confirmation:lower() == "yes" then
			delete_session.delete_session(session.id)
		else
			vim.notify("Session deletion cancelled", vim.log.levels.INFO)
		end
	end)
end

return M