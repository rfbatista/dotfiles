local M = {}

-- Import all chat modules
local create_session = require("ai.chat.core.create_session")
local delete_session = require("ai.chat.core.delete_session")
local get_current_session = require("ai.chat.core.get_current_session")
local set_current_session = require("ai.chat.core.set_current_session")
local get_sessions = require("ai.chat.core.get_sessions")

local add_message = require("ai.chat.communication.add_message")
local get_messages = require("ai.chat.communication.get_messages")
local get_current_terminal = require("ai.chat.communication.get_current_terminal")
local toggle_current_terminal = require("ai.chat.communication.toggle_current_terminal")

local show_session_picker = require("ai.chat.ui.show_session_picker")
local delete_session_picker = require("ai.chat.ui.delete_session_picker")
local create_session_prompt = require("ai.chat.ui.create_session_prompt")
local delete_current_session_prompt = require("ai.chat.ui.delete_current_session_prompt")
local delete_session_prompt = require("ai.chat.ui.delete_session_prompt")

local setup_commands = require("ai.chat.commands.setup_commands")
local persistence = require("ai.chat.shared.persistence")

-- Expose core functions
M.create_session = create_session.create_session
M.delete_session = delete_session.delete_session
M.get_current_session = get_current_session.get_current_session
M.set_current_session = set_current_session.set_current_session
M.get_sessions = get_sessions.get_sessions

-- Expose communication functions
M.add_message = add_message.add_message
M.get_messages = get_messages.get_messages
M.get_current_terminal = get_current_terminal.get_current_terminal
M.toggle_current_terminal = toggle_current_terminal.toggle_current_terminal

-- Expose UI functions
M.show_session_picker = show_session_picker.show_session_picker
M.delete_session_picker = delete_session_picker.show_delete_session_picker
M.create_session_prompt = create_session_prompt.create_session_prompt
M.delete_current_session_prompt = delete_current_session_prompt.delete_current_session_prompt
M.delete_session_prompt = delete_session_prompt.delete_session_prompt

-- Initialize persistence and commands
persistence.load_sessions()
-- setup_commands.setup_commands()

return M
