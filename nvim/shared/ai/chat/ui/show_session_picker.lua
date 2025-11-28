local M = {}

local storage = require("ai.chat.shared.storage")
local set_current_session = require("ai.chat.core.set_current_session")
local create_session_prompt = require("ai.chat.ui.create_session_prompt")
local terminal = require("ai.terminal")

---Session picker UI using snack
function M.show_session_picker()
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

	-- Add option to create new session
	table.insert(items, {
		value = "__create_new__",
		text = "➕ Create New Session",
		desc = "Create a new chat session with terminal",
	})

	snack.select(items, {
		prompt = "Select Chat Session:",
		format_item = function(item)
			return item.text
		end,
	}, function(selected)
		if not selected then
			return
		end

		if selected.value == "__create_new__" then
			create_session_prompt.create_session_prompt()
		else
			set_current_session.set_current_session(selected.value)
		end
	end)
end

return M

