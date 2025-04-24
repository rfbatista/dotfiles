local M = {}

local terminal = require("user.aider.terminal")
local vim_notify = require("notify")
vim.notify = vim_notify

vim.keymap.set({ "n", "t" }, "<A-o>", function()
	M.toggle()
end, { noremap = true, silent = true })

function M.select_template()
	-- Get all files (non-recursively) under the "templates" folder.
	local folder = "_templates"
	local files = vim.fn.globpath(folder, "*.tpl", false, true)
	if #files == 0 then
		vim.notify("No template files found in " .. folder, vim.log.levels.WARN)
		return
	end
	-- Show a selectable popup list
	vim.ui.select(files, {
		prompt = "Select a template file:",
		format_item = function(item)
			return vim.fn.fnamemodify(item, ":t") -- show only the filename in the list
		end,
	}, function(choice)
		if choice then
			-- Read the file content as a list of lines and join them into a single string
			local fileContent = table.concat(vim.fn.readfile(choice), "\n")
			local selected_text = fileContent
			-- Store the file content in a module-level variable if needed
			local input = vim.fn.input("Add a prompt to your selection (empty to skip):")
			if input ~= nil and input ~= "" then
				selected_text = input .. "\n> " .. selected_text
			end
			M.toggle()
			terminal.send_to_terminal(selected_text)
			-- M.selected_template = fileContent
		end
	end)
end

function M.toggle()
	terminal.toggle()
end

function M.send_file()
	local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
	local file_type = vim.bo.filetype
	file_type = file_type == "" and "text" or file_type
	local file_path = vim.api.nvim_buf_get_name(0)
	selected_text = "File: " .. file_path .. "\n" .. selected_text
	local input = vim.fn.input("Prompt to file:")
	if input ~= nil and input ~= "" then
		selected_text = input .. "\n> " .. selected_text
	end
	M.toggle()
	terminal.send_to_terminal(selected_text)
end

return M
