local M = {}

local storage = require("ai.terminal.shared.storage")
local config = require("ai.config")
local utils = require("ai.terminal.shared.utils")
local Terminal = require("toggleterm.terminal").Terminal

local next_terminal_id = 100

---@param term_opts table
---@param cmd string
---@return table
local function build_toggleterm_opts(term_opts, cmd)
	local opts = {
		cmd = cmd,
		hidden = true,
		direction = "float",
		close_on_exit = false,
	}

	if term_opts and term_opts.win and term_opts.win.border then
		opts.float_opts = { border = term_opts.win.border }
	end
	if term_opts and term_opts.env then
		opts.env = term_opts.env
	end
	if term_opts and term_opts.dir then
		opts.dir = term_opts.dir
	end

	if term_opts and term_opts.id then
		opts.id = term_opts.id
	else
		opts.id = next_terminal_id
		next_terminal_id = next_terminal_id + 1
	end

	return opts
end

---Create a new named terminal
---@param name string Name for the terminal
---@param cmd? string Command to run (default: from config). Use e.g. 'cursor-agent --resume="session_id"' to restore.
---@param opts? table Terminal options
---@return snacks.win?
function M.create_named(name, cmd, opts)
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

	-- Use provided cmd when it's a custom command (e.g. cursor-agent --resume="id"); otherwise build from config
	if not cmd or cmd == "" or cmd == vim.o.shell then
		cmd = utils.create_cmd(term_opts)
	end

	local term = Terminal:new(build_toggleterm_opts(term_opts, cmd))
	term:toggle()

	if term then
		local term_info = {
			term = term,
			cmd = cmd,
			opts = term_opts,
			created_at = os.time(),
			session_id = opts.session_id,
		}
		storage.add_named_terminal(name, term_info)
		-- Set as active terminal
		storage.set_active_terminal_name(name)
		vim.notify("Created named terminal: " .. name, vim.log.levels.INFO)
	end

	return term
end

return M

