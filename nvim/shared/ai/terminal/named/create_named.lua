local M = {}

local storage = require("ai.terminal.shared.storage")
local config = require("ai.config")
local utils = require("ai.terminal.shared.utils")

---Create a new named terminal
---@param name string Name for the terminal
---@param cmd? string Command to run (default: shell)
---@param opts? table Terminal options
---@return snacks.win?
function M.create_named(name, cmd, opts)
	cmd = cmd or vim.o.shell
	opts = opts or {}

	-- Create terminal options with name
	local term_opts = vim.tbl_deep_extend("force", {
		name = name,
		win = {
			wo = { winbar = name },
		},
		env = {
			session_name = name,
		},
	}, opts)
	term_opts = vim.tbl_deep_extend("force", config.options, term_opts)
	cmd = utils.create_cmd(term_opts)
	local snacks = require("snacks.terminal")
	local term = snacks.toggle(cmd, term_opts)

	if term then
		local term_info = {
			term = term,
			cmd = cmd,
			opts = term_opts,
			created_at = os.time(),
		}
		storage.add_named_terminal(name, term_info)
		-- Set as active terminal
		storage.set_active_terminal_name(name)
		vim.notify("Created named terminal: " .. name, vim.log.levels.INFO)
	end

	return term
end

return M

