local M = {}

local terminal = require("ai.terminal")
local chat = require("ai.chat")
local vim_notify = require("notify")
local commands = require("ai.commands")
local send_selection = require("ai.commands.send_selection")
vim.notify = vim_notify

function M.toggle()
	chat.toggle_current_terminal()
end

function M.send_file()
	local file_path = vim.api.nvim_buf_get_name(0)
	terminal.send(commands.add.build(file_path))
end

function M.send_selection()
	send_selection()
end

function M.show_session_picker()
	chat.show_session_picker()
end

function M.delete_session()
	chat.delete_session_picker()
end

vim.keymap.set({ "n", "t" }, "<A-o>", function()
	M.toggle()
end, { noremap = true, silent = true })

vim.keymap.set("v", "<A-s>", function()
	M.send_selection()
end, { noremap = true, silent = true })

return M
