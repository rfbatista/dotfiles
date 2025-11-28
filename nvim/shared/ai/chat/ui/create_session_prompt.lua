local M = {}

local create_session = require("ai.chat.core.create_session")

---Create session with name prompt
function M.create_session_prompt()
	vim.ui.input({
		prompt = "Session name: ",
		default = "",
	}, function(name)
		if name and name ~= "" then
			create_session.create_session(name)
		end
	end)
end

return M