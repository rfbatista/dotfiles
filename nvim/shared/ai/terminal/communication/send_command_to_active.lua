local M = {}

local get_active_terminal = require("ai.terminal.named.get_active_terminal")
local send_command_to_named = require("ai.terminal.communication.send_command_to_named")

---Send command to active terminal
---@param command string Command to send
---@param text? string Additional text after command
function M.send_command_to_active(command, text)
	local active_name = get_active_terminal.get_active_terminal()
	if not active_name then
		vim.notify("No active terminal", vim.log.levels.WARN)
		return
	end
	
	send_command_to_named.send_command_to_named(active_name, command, text)
end

return M