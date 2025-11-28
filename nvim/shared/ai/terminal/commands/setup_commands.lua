local M = {}

---Setup commands for named terminals
function M.setup_commands()
	vim.api.nvim_create_user_command("TerminalCreate", function(opts)
		local name = opts.args
		if name and name ~= "" then
			vim.ui.input({
				prompt = "Command (empty for shell): ",
				default = vim.o.shell,
			}, function(cmd)
				local create_named = require("ai.terminal.named.create_named")
				create_named.create_named(name, cmd or vim.o.shell)
			end)
		else
			local create_terminal_prompt = require("ai.terminal.picker.create_terminal_prompt")
			create_terminal_prompt.create_terminal_prompt()
		end
	end, {
		nargs = "?",
		desc = "Create a new named terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalList", function()
		local show_terminal_picker = require("ai.terminal.picker.show_terminal_picker")
		show_terminal_picker.show_terminal_picker()
	end, {
		desc = "Show terminal picker",
	})
	
	vim.api.nvim_create_user_command("TerminalListDelete", function()
		local show_terminal_picker_with_delete = require("ai.terminal.picker.show_terminal_picker_with_delete")
		show_terminal_picker_with_delete.show_terminal_picker_with_delete()
	end, {
		desc = "Show terminal picker with delete options",
	})
	
	vim.api.nvim_create_user_command("TerminalToggle", function(opts)
		if opts.args and opts.args ~= "" then
			local toggle_named = require("ai.terminal.named.toggle_named")
			toggle_named.toggle_named(opts.args)
		else
			vim.notify("Please provide a terminal name", vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		desc = "Toggle a named terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalDelete", function(opts)
		if opts.args and opts.args ~= "" then
			local delete_named = require("ai.terminal.named.delete_named")
			delete_named.delete_named(opts.args)
		else
			vim.notify("Please provide a terminal name", vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		desc = "Delete a named terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalSend", function(opts)
		local args = vim.split(opts.args, " ", { plain = true })
		if #args >= 2 then
			local name = args[1]
			local text = table.concat(args, " ", 2)
			local send_to_named = require("ai.terminal.communication.send_to_named")
			send_to_named.send_to_named(name, text)
		else
			vim.notify("Usage: TerminalSend <name> <text>", vim.log.levels.ERROR)
		end
	end, {
		nargs = "+",
		desc = "Send text to a named terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalSendActive", function(opts)
		if opts.args and opts.args ~= "" then
			local send_to_active = require("ai.terminal.communication.send_to_active")
			send_to_active.send_to_active(opts.args)
		else
			vim.notify("Please provide text to send", vim.log.levels.ERROR)
		end
	end, {
		nargs = "+",
		desc = "Send text to active terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalSetActive", function(opts)
		if opts.args and opts.args ~= "" then
			local set_active_terminal = require("ai.terminal.named.set_active_terminal")
			set_active_terminal.set_active_terminal(opts.args)
		else
			vim.notify("Please provide a terminal name", vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		desc = "Set active terminal",
	})
	
	vim.api.nvim_create_user_command("TerminalActive", function()
		local get_active_terminal = require("ai.terminal.named.get_active_terminal")
		local active = get_active_terminal.get_active_terminal()
		if active then
			vim.notify("Active terminal: " .. active, vim.log.levels.INFO)
		else
			vim.notify("No active terminal", vim.log.levels.WARN)
		end
	end, {
		desc = "Show active terminal",
	})
end

return M