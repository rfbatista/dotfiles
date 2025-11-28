local M = {}

local get_active_terminal = require("ai.terminal.named.get_active_terminal")
local send_to_named = require("ai.terminal.communication.send_to_named")

---Send text to active terminal
---@param text string Text to send
---@param multi_line? boolean Whether to send as multi-line text
function M.send_to_active(text, multi_line)
	local active_name = get_active_terminal.get_active_terminal()
	if not active_name then
		vim.notify("No active terminal", vim.log.levels.WARN)
		return
	end
	
	send_to_named.send_to_named(active_name, text, multi_line)
end

return M