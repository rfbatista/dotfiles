local M = {}

local send_to_named = require("ai.terminal.communication.send_to_named")

---Send command to a named terminal
---@param name string Name of the terminal
---@param command string Command to send
---@param text? string Additional text after command
function M.send_command_to_named(name, command, text)
	text = text or ""
	send_to_named.send_to_named(name, command .. " " .. text, false)
end

return M