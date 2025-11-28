local M = {}

local storage = require("ai.chat.shared.storage")
local persistence = require("ai.chat.shared.persistence")
local utils = require("ai.chat.shared.utils")
local terminal = require("ai.terminal")

---Create a new chat session
---@param name string
---@return table
function M.create_session(name)
	if not name or name == "" then
		name = "Session " .. (vim.fn.strftime("%Y-%m-%d %H:%M:%S"))
	end

	local session_id = utils.generate_session_id()
	-- local terminal_name = utils.generate_terminal_name(session_id)

	local session = {
		id = session_id,
		name = name,
		created_at = os.time(),
		messages = {},
		terminal_name = name,
	}

	storage.add_session(session_id, session)
	storage.set_current_session_id(session_id)

	-- Create associated terminal
	local term = terminal.create_named(session.terminal_name)

	if term then
		vim.notify("Created new session: " .. name .. " with terminal", vim.log.levels.INFO)
	else
		vim.notify("Created new session: " .. name .. " (terminal creation failed)", vim.log.levels.WARN)
	end

	persistence.save_sessions()
	return session
end

return M
