local M = {}
local cursor = {}
local aider = {}

local AIDER_COMMAND_PREFIX = "/"

aider.add = {
	description = "Add files to the chat so aider can edit them or review them in detail",
	category = "input",
	build = function(file_path)
		return AIDER_COMMAND_PREFIX .. "add" .. " " .. file_path
	end,
}

cursor.add = {
	description = "Add files to the chat so aider can edit them or review them in detail",
	category = "input",
	build = function(file_path)
		return "@" .. file_path
	end,
}

M = cursor
-- M = aider

return M
