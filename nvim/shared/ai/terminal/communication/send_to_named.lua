local M = {}

local utils = require("ai.terminal.shared.utils")
local get_named = require("ai.terminal.named.get_named")

---Send text to a named terminal
---@param name string Name of the terminal
---@param text string Text to send
---@param multi_line? boolean Whether to send as multi-line text
function M.send_to_named(name, text, multi_line)
	multi_line = multi_line == nil and true or multi_line
	
	local term = get_named.get_named(name)
	if not term then
		vim.notify("Named terminal '" .. name .. "' not found", vim.log.levels.ERROR)
		return
	end
	
	if utils.is_terminal_valid(term) then
		local chan = utils.get_terminal_channel(term)
		if chan then
			utils.send_to_channel(chan, text, multi_line)
		else
			vim.notify("No terminal job found for '" .. name .. "'", vim.log.levels.ERROR)
		end
	else
		vim.notify("Terminal '" .. name .. "' is not valid", vim.log.levels.ERROR)
	end
end

return M