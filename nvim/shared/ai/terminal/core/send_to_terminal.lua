local M = {}

local send = require("ai.terminal.core.send")

---Send text to aider terminal
---@param text? string Optional text to send (nil for visual selection/mode-based handling)
---@param opts? table Optional configuration override
function M.send_to_terminal(text, opts)
	local mode = vim.fn.mode()
	local selected_text = text or ""
	-- Visual mode handling
	if vim.tbl_contains({ "v", "V", "" }, mode) then
		local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
		selected_text = table.concat(lines, "\n")

		vim.ui.input({ prompt = "Add a prompt to your selection (empty to skip):" }, function(input)
			if input ~= nil then
				if input ~= "" then
					selected_text = selected_text .. "\n> " .. input
				end
				send.send(selected_text, opts or {}, true)
			end
		end)
	else
		-- Normal mode handling
		if selected_text == "" then
			vim.ui.input({ prompt = "Send to Aider: " }, function(input)
				if input then
					send.send(input, opts or {})
				end
			end)
		else
			send.send(selected_text, opts or {}, true)
		end
	end
end

return M