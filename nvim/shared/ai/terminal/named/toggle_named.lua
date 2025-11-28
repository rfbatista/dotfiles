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
	
	local snacks = require("snacks.terminal")
	local named_terminals = storage.get_named_terminals()
	
	-- If terminal exists, toggle it
	if named_terminals[name] then
		local term_opts = vim.tbl_deep_extend("force", named_terminals[name].opts, opts)
		local term = snacks.toggle(named_terminals[name].cmd, term_opts)
		
		if term then
			named_terminals[name].term = term
			-- Set as active terminal
			storage.set_active_terminal_name(name)
		else
			-- Terminal was closed, remove from storage
			storage.remove_named_terminal(name)
			-- Clear active if this was the active terminal
			if storage.get_active_terminal_name() == name then
				storage.set_active_terminal_name(nil)
			end
		end
		
		return term
	else
		-- Create new terminal
		return create_named.create_named(name, cmd, opts)
	end
end

return M