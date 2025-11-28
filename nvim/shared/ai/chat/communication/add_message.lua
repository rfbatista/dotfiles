local M = {}

local storage = require("ai.chat.shared.storage")
local persistence = require("ai.chat.shared.persistence")
local utils = require("ai.chat.shared.utils")
local get_current_session = require("ai.chat.core.get_current_session")
local terminal = require("ai.terminal")

---Add message to current session
---@param role string
---@param content string
---@return boolean
function M.add_message(role, content)
	local session = get_current_session.get_current_session()
	if not session then
		vim.notify("No active session. Create one first.", vim.log.levels.WARN)
		return false
	end
	
	local message = {
		role = role, -- "user" or "assistant"
		content = content,
		timestamp = os.time(),
	}
	
	table.insert(session.messages, message)
	persistence.save_sessions()
	
	-- Send message to associated terminal if it exists
	if session.terminal_name then
		local terminal_name = session.terminal_name
		local formatted_message = utils.format_message_for_terminal(role, content)
		terminal.send_to_named(terminal_name, formatted_message)
	end
	
	return true
end

return M