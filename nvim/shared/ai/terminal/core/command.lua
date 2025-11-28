local M = {}

local config = require("ai.config")
local send = require("ai.terminal.core.send")

---Send a command to the terminal
---@param command string Aider command (e.g. "/add")
---@param text? string Text to send after the command
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
function M.command(command, text, opts)
	text = text or ""

	opts = vim.tbl_deep_extend("force", config.options, opts or {})
	-- NOTE: For Aider commands that shouldn't get a newline (e.g. `/add file`)
	send.send(command .. " " .. text, opts, false)
end

return M