local M = {}

---Setup commands for chat sessions
function M.setup_commands()
	vim.api.nvim_create_user_command("ChatSessionNew", function(opts)
		local create_session = require("ai.chat.core.create_session")
		create_session.create_session(opts.args)
	end, {
		nargs = "?",
		desc = "Create a new chat session",
	})
	
	vim.api.nvim_create_user_command("ChatSessionList", function()
		local show_session_picker = require("ai.chat.ui.show_session_picker")
		show_session_picker.show_session_picker()
	end, {
		desc = "Show session picker",
	})
	
	vim.api.nvim_create_user_command("ChatSessionDelete", function(opts)
		if opts.args and opts.args ~= "" then
			local delete_session = require("ai.chat.core.delete_session")
			delete_session.delete_session(opts.args)
		else
			vim.notify("Please provide a session ID to delete", vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		desc = "Delete a chat session by ID",
	})
	
	vim.api.nvim_create_user_command("ChatSessionSwitch", function(opts)
		if opts.args and opts.args ~= "" then
			local set_current_session = require("ai.chat.core.set_current_session")
			set_current_session.set_current_session(opts.args)
		else
			vim.notify("Please provide a session ID to switch to", vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		desc = "Switch to a chat session by ID",
	})
	
	vim.api.nvim_create_user_command("ChatSessionCurrent", function()
		local get_current_session = require("ai.chat.core.get_current_session")
		local session = get_current_session.get_current_session()
		if session then
			local terminal_info = ""
			if session.terminal_name then
				local terminal = require("ai.terminal")
				local term = terminal.get_named(session.terminal_name)
				terminal_info = " | Terminal: " .. (term and term:buf_valid() and "running" or "closed")
			end
			vim.notify("Current session: " .. session.name .. " (ID: " .. session.id .. ")" .. terminal_info, vim.log.levels.INFO)
		else
			vim.notify("No current session", vim.log.levels.WARN)
		end
	end, {
		desc = "Show current session info",
	})
	
	vim.api.nvim_create_user_command("ChatTerminalToggle", function()
		local toggle_current_terminal = require("ai.chat.communication.toggle_current_terminal")
		toggle_current_terminal.toggle_current_terminal()
	end, {
		desc = "Toggle current session's terminal",
	})
	
	vim.api.nvim_create_user_command("ChatMessageAdd", function(opts)
		local args = vim.split(opts.args, " ", { plain = true })
		if #args >= 2 then
			local role = args[1]
			local content = table.concat(args, " ", 2)
			local add_message = require("ai.chat.communication.add_message")
			add_message.add_message(role, content)
		else
			vim.notify("Usage: ChatMessageAdd <role> <content>", vim.log.levels.ERROR)
		end
	end, {
		nargs = "+",
		desc = "Add a message to current session",
	})
	
	vim.api.nvim_create_user_command("ChatMessagesGet", function()
		local get_messages = require("ai.chat.communication.get_messages")
		local messages = get_messages.get_messages()
		if #messages > 0 then
			for i, msg in ipairs(messages) do
				print(string.format("[%d] %s: %s", i, msg.role, msg.content))
			end
		else
			vim.notify("No messages in current session", vim.log.levels.INFO)
		end
	end, {
		desc = "Get messages from current session",
	})
end

return M