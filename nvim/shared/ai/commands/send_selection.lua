local terminal = require("ai.terminal")
local commands = require("ai.commands")

return function()
	-- Get current buffer info
	local file_path = vim.api.nvim_buf_get_name(0)
	if file_path == "" then
		vim.notify("No file path available", vim.log.levels.WARN)
		return
	end

	-- Get visual selection using a more reliable method
	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")

	-- Alternative method: try to get from visual marks
	local start_line, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
	local end_line, end_col = unpack(vim.fn.getpos("'>"), 2, 3)

	-- If visual marks are not set, try to get from current cursor position
	if start_line == 0 or end_line == 0 then
		-- Check if we're in visual mode
		local mode = vim.fn.mode()
		if not string.match(mode, "[vV]") then
			vim.notify("No selection found. Please select text in visual mode first.", vim.log.levels.WARN)
			return
		end

		-- Use cursor position as fallback
		start_line = start_pos[2]
		end_line = end_pos[2]
		start_col = start_pos[3]
		end_col = end_pos[3]
	end

	-- Ensure start_line is before end_line
	if start_line > end_line then
		start_line, end_line = end_line, start_line
		start_col, end_col = end_col, start_col
	end

	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	if #lines == 0 then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Ask for prompt text using snacks.input
	local snack = require("snacks.input")
	snack.input({
		prompt = "Enter prompt text: ",
		default = "",
		placeholder = "e.g., Please review this code and suggest improvements",
	}, function(prompt_text)
		if not prompt_text or prompt_text == "" then
			vim.notify("No prompt text provided, skipping", vim.log.levels.INFO)
			return
		end
		local file_path = vim.api.nvim_buf_get_name(0)

		-- Build the content with prompt text, line numbers and file path
		local content = {}
		table.insert(content, prompt_text)
		table.insert(content, "")
		table.insert(content, "File: " .. "@" .. file_path)
		table.insert(content, "Lines: " .. start_line .. "-" .. end_line)
		table.insert(content, "")

		-- Add each line with line number
		for i, line in ipairs(lines) do
			local line_num = start_line + i - 1
			table.insert(content, string.format("%d: %s", line_num, line))
		end

		-- Join all lines
		local selection_text = table.concat(content, "\n")

		-- Send to terminal using aider add command
		-- terminal.send(commands.aider.add.build(content))

		-- Send the selection content with prompt
		terminal.send(selection_text)

		vim.notify("Selection with prompt sent to terminal", vim.log.levels.INFO)
	end)
end
