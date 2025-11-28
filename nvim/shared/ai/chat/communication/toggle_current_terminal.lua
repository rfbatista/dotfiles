local M = {}

local get_current_session = require("ai.chat.core.get_current_session")
local terminal = require("ai.terminal")

---Toggle current session's terminal
---@return snacks.win?
function M.toggle_current_terminal()
	local session = get_current_session.get_current_session()
	if session and session.terminal_name then
		return terminal.toggle_named(session.terminal_name)
	else
		vim.notify("No active session with terminal", vim.log.levels.WARN)
		return nil
	end
end

return M