local M = {}

local storage = require("ai.terminal.shared.storage")
local create_named = require("ai.terminal.named.create_named")

---Toggle a named terminal
---@param name string Name of the terminal
---@param cmd? string Command to run if creating new
---@param opts? table Terminal options
---@return snacks.win?
function M.toggle_named(name, cmd, opts)
	cmd = cmd or vim.o.shell
	opts = opts or {}

	local named_terminals = storage.get_named_terminals()

	-- If terminal exists, toggle it
	if named_terminals[name] then
		local term_info = named_terminals[name]
		if term_info and term_info.term and require("ai.terminal.shared.utils").is_terminal_valid(term_info.term) then
			term_info.term:toggle()
			-- Set as active terminal
			storage.set_active_terminal_name(name)
			return term_info.term
		else
			storage.remove_named_terminal(name)
			-- Clear active if this was the active terminal
			if storage.get_active_terminal_name() == name then
				storage.set_active_terminal_name(nil)
			end
			return create_named.create_named(name, cmd, opts)
		end
	else
		-- Create new terminal
		return create_named.create_named(name, cmd, opts)
	end
end

return M