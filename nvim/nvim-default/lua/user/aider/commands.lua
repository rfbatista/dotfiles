local M = {}

local COMMAND_PREFIX = "/"

M.add = {
	value = COMMAND_PREFIX .. "add",
	description = "Add files to the chat so aider can edit them or review them in detail",
	category = "input",
}

return M
