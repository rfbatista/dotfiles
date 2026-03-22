local M = {}

local config = require("ai.config")
local utils = require("ai.terminal.shared.utils")
local storage = require("ai.terminal.shared.storage")

---Send text to terminal
---@param text string Text to send
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
---@param multi_line? boolean Whether to send as multi-line text (default: true)
function M.send(text, opts, multi_line)
	multi_line = multi_line == nil and true or multi_line
	opts = vim.tbl_deep_extend("force", config.options, opts or {})

	-- Try to use active named terminal first
	local active_terminal_name = storage.get_active_terminal_name()
	if active_terminal_name then
		local named_terminals = storage.get_named_terminals()
		local term_info = named_terminals[active_terminal_name]
		if term_info and term_info.term then
			local chan = utils.get_terminal_channel(term_info.term)
			if chan then
				utils.send_to_channel(chan, text, multi_line)
				return
			end
		end
	end

	-- Fallback to original aider terminal
	local cmd = utils.create_cmd(opts)
	local default_info = storage.get_default_terminal_info()
	local term = default_info and default_info.term
	if not utils.is_terminal_valid(term) or (default_info and default_info.cmd ~= cmd) then
		vim.notify("Please open an Aider terminal first.", vim.log.levels.INFO)
		return
	end

	local chan = utils.get_terminal_channel(term)
	if chan then
		utils.send_to_channel(chan, text, multi_line)
	else
		vim.notify("No Aider terminal job found!", vim.log.levels.ERROR)
	end
end

return M