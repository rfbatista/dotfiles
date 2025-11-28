local M = {}

-- Terminal storage for named terminals
local named_terminals = {}
local active_terminal_name = nil

---Get named terminals storage
---@return table
function M.get_named_terminals()
	return named_terminals
end

---Set named terminals storage
---@param terminals table
function M.set_named_terminals(terminals)
	named_terminals = terminals
end

---Get active terminal name
---@return string?
function M.get_active_terminal_name()
	return active_terminal_name
end

---Set active terminal name
---@param name string?
function M.set_active_terminal_name(name)
	active_terminal_name = name
end

---Add named terminal to storage
---@param name string
---@param info table
function M.add_named_terminal(name, info)
	named_terminals[name] = info
end

---Remove named terminal from storage
---@param name string
function M.remove_named_terminal(name)
	named_terminals[name] = nil
end

---Get named terminal info
---@param name string
---@return table?
function M.get_named_terminal_info(name)
	return named_terminals[name]
end

return M