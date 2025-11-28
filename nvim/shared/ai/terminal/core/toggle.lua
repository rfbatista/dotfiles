local M = {}

local config = require("ai.config")
local utils = require("ai.terminal.shared.utils")
local storage = require("ai.terminal.shared.storage")

---Toggle terminal visibility
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
---@return snacks.win?
function M.toggle(opts)
	local snacks = require("snacks.terminal")

	-- If there's an active named terminal, toggle that instead
	local active_terminal_name = storage.get_active_terminal_name()
	if active_terminal_name then
		local named = require("ai.terminal.named.toggle_named")
		return named.toggle_named(active_terminal_name)
	end

	opts = vim.tbl_deep_extend("force", config.options, opts or {})

	local cmd = utils.create_cmd(opts)
	return snacks.toggle(cmd, opts)
end

return M