local M = {}

-- Import all terminal modules
local toggle = require("ai.terminal.core.toggle")
local send = require("ai.terminal.core.send")
local command = require("ai.terminal.core.command")
local send_to_terminal = require("ai.terminal.core.send_to_terminal")

local create_named = require("ai.terminal.named.create_named")
local get_named = require("ai.terminal.named.get_named")
local toggle_named = require("ai.terminal.named.toggle_named")
local delete_named = require("ai.terminal.named.delete_named")
local list_named = require("ai.terminal.named.list_named")
local set_active_terminal = require("ai.terminal.named.set_active_terminal")
local get_active_terminal = require("ai.terminal.named.get_active_terminal")

local send_to_named = require("ai.terminal.communication.send_to_named")
local send_to_active = require("ai.terminal.communication.send_to_active")
local send_command_to_named = require("ai.terminal.communication.send_command_to_named")
local send_command_to_active = require("ai.terminal.communication.send_command_to_active")

local show_terminal_picker = require("ai.terminal.picker.show_terminal_picker")
local show_terminal_picker_with_delete = require("ai.terminal.picker.show_terminal_picker_with_delete")
local create_terminal_prompt = require("ai.terminal.picker.create_terminal_prompt")
local delete_terminal_prompt = require("ai.terminal.picker.delete_terminal_prompt")

local setup_commands = require("ai.terminal.commands.setup_commands")

-- Expose core functions
M.toggle = toggle.toggle
M.send = send.send
M.command = command.command
M.send_to_terminal = send_to_terminal.send_to_terminal

-- Expose named terminal functions
M.create_named = create_named.create_named
M.get_named = get_named.get_named
M.toggle_named = toggle_named.toggle_named
M.delete_named = delete_named.delete_named
M.list_named = list_named.list_named
M.set_active_terminal = set_active_terminal.set_active_terminal
M.get_active_terminal = get_active_terminal.get_active_terminal

-- Expose communication functions
M.send_to_named = send_to_named.send_to_named
M.send_to_active = send_to_active.send_to_active
M.send_command_to_named = send_command_to_named.send_command_to_named
M.send_command_to_active = send_command_to_active.send_command_to_active

-- Expose picker functions
M.show_terminal_picker = show_terminal_picker.show_terminal_picker
M.create_terminal_prompt = create_terminal_prompt.create_terminal_prompt
M.show_terminal_picker_with_delete = show_terminal_picker_with_delete.show_terminal_picker_with_delete
M.delete_terminal_prompt = delete_terminal_prompt.delete_terminal_prompt

-- Initialize commands
setup_commands.setup_commands()

return M