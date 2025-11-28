local M = {}

local storage = require("ai.terminal.shared.storage")
local delete_named = require("ai.terminal.named.delete_named")

---Delete terminal with confirmation
---@param terminal_name string
---@param refresh_callback function?
function M.delete_terminal_prompt(terminal_name, refresh_callback)
	vim.ui.input({
		prompt = string.format("Delete terminal '%s'? Type 'yes' to confirm: ", terminal_name),
		default = "",
	}, function(confirmation)
		if confirmation and confirmation:lower() == "yes" then
			delete_named.delete_named(terminal_name)
			-- Call refresh callback if provided
			if refresh_callback then
				refresh_callback()
			end
		else
			vim.notify("Terminal deletion cancelled", vim.log.levels.INFO)
		end
	end)
end

return M