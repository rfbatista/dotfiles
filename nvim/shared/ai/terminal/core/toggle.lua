local M = {}

local config = require("ai.config")
local utils = require("ai.terminal.shared.utils")
local storage = require("ai.terminal.shared.storage")
local Terminal = require("toggleterm.terminal").Terminal

---@param opts nvim_aider.Config
---@param cmd string
---@return table
local function build_toggleterm_opts(opts, cmd)
	local term_opts = {
		cmd = cmd,
		hidden = true,
		direction = "float",
		close_on_exit = false,
	}

	if opts and opts.win and opts.win.border then
		term_opts.float_opts = { border = opts.win.border }
	end

	return term_opts
end

---Toggle terminal visibility
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
---@return snacks.win?
function M.toggle(opts)
	-- If there's an active named terminal, toggle that instead
	local active_terminal_name = storage.get_active_terminal_name()
	if active_terminal_name then
		local named = require("ai.terminal.named.toggle_named")
		return named.toggle_named(active_terminal_name)
	end

	opts = vim.tbl_deep_extend("force", config.options, opts or {})

	local cmd = utils.create_cmd(opts)
	local default_info = storage.get_default_terminal_info()
	local term = default_info and default_info.term

	if (not utils.is_terminal_valid(term)) or (default_info and default_info.cmd ~= cmd) then
		term = Terminal:new(build_toggleterm_opts(opts, cmd))
		storage.set_default_terminal_info({ term = term, cmd = cmd, opts = opts })
	end

	term:toggle()
	return term
end

return M
