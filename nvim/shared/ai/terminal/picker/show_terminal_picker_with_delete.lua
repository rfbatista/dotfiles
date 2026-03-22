local M = {}

local storage = require("ai.terminal.shared.storage")
local utils = require("ai.terminal.shared.utils")
local toggle_named = require("ai.terminal.named.toggle_named")
local create_terminal_prompt = require("ai.terminal.picker.create_terminal_prompt")

---Show terminal picker with delete options
function M.show_terminal_picker_with_delete()
	local snack = require("snacks.picker")
	local named_terminals = storage.get_named_terminals()
	
	local items = {}
	for name, info in pairs(named_terminals) do
		local is_valid = utils.is_terminal_valid(info.term)
		local status = is_valid and " (running)" or " (closed)"
		local created = os.date("%Y-%m-%d %H:%M", info.created_at)
		
		table.insert(items, {
			value = name,
			text = name .. status,
			desc = string.format("Command: %s | Created: %s", info.cmd, created),
		})
		
		-- Add delete option for each terminal
		table.insert(items, {
			value = "__delete_" .. name,
			text = "🗑️ Delete: " .. name,
			desc = string.format("Delete terminal '%s'", name),
		})
	end
	
	-- Add option to create new terminal
	table.insert(items, {
		value = "__create_new__",
		text = "➕ Create New Terminal",
		desc = "Create a new named terminal",
	})
	
	snack.select(items, {
		prompt = "Select Terminal:",
		format_item = function(item)
			return item.text
		end,
	}, function(selected)
		if not selected then return end
		
		if selected.value == "__create_new__" then
			create_terminal_prompt.create_terminal_prompt()
		elseif selected.value:match("^__delete_") then
			local terminal_name = selected.value:gsub("^__delete_", "")
			-- Import delete function locally to avoid circular dependency
			local delete_terminal_prompt = require("ai.terminal.picker.delete_terminal_prompt")
			delete_terminal_prompt.delete_terminal_prompt(terminal_name, M.show_terminal_picker_with_delete)
		else
			toggle_named.toggle_named(selected.value)
		end
	end)
end

return M