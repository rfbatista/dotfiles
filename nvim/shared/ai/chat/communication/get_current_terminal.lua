local M = {}

local get_current_session = require("ai.chat.core.get_current_session")
local terminal = require("ai.terminal")

---Get current session's terminal
---@return snacks.win?
function M.get_current_terminal()
	local session = get_current_session.get_current_session()
	if session and session.terminal_name then
		return terminal.get_named(session.terminal_name)
	end
	return nil
end

return M