local M = {}

local storage = require("ai.chat.shared.storage")
local delete_session = require("ai.chat.core.delete_session")
local terminal = require("ai.terminal")

---Delete session picker UI using snack
function M.show_delete_session_picker()
	local snack = require("snacks.picker")
	local sessions = storage.get_sessions()
	local current_session_id = storage.get_current_session_id()

	local items = {}
	for session_id, session in pairs(sessions) do
		local is_current = session_id == current_session_id
		local status = is_current and " (current)" or ""
		local created = os.date("%Y-%m-%d %H:%M", session.created_at)
		local message_count = #session.messages

		-- Check if terminal is running
		local terminal_status = ""
		if session.terminal_name then
			local term = terminal.get_named(session.terminal_name)
			terminal_status = term and term:buf_valid() and " | Terminal: running" or " | Terminal: closed"
		end

		table.insert(items, {
			value = session_id,
			text = session.name .. status,
			desc = string.format("Created: %s | Messages: %d%s", created, message_count, terminal_status),
		})
	end

	-- If no sessions exist, show a message
	if #items == 0 then
		vim.notify("No sessions to delete", vim.log.levels.INFO)
		return
	end

	snack.select(items, {
		prompt = "Delete Chat Session:",
		format_item = function(item)
			return item.text
		end,
	}, function(selected)
		if not selected then
			return
		end

		-- Confirm deletion
		local session = sessions[selected.value]
		local session_name = session.name
		local is_current = selected.value == current_session_id

		local confirm_msg = string.format(
			"Are you sure you want to delete session '%s'?%s",
			session_name,
			is_current and " (This is your current session)" or ""
		)

		vim.ui.select({ "Yes", "No" }, {
			prompt = confirm_msg,
		}, function(choice)
			if choice == "Yes" then
				delete_session.delete_session(selected.value)
			end
		end)
	end)
end

return M

