local M = {}

local vim_notify = require("notify")
vim.notify = vim_notify

-- Utility function to call aider with the given query
function M.request(query)
	local cmd = { "aider", query } -- adjust if aider needs more flags/arguments
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				-- For example, display aider output as a notification.
				vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
			end
		end,
		on_stderr = function(_, data)
			if data then
				vim.notify("Aider error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
			end
		end,
	})
end

-- Setup the aide plugin by creating a user command
function M.setup()
	vim.api.nvim_create_user_command("AiderRequest", function(opts)
		if opts.args == "" then
			vim.notify("Please provide a query for aider", vim.log.levels.WARN)
			return
		end
		M.request(opts.args)
	end, {
		nargs = 1, -- requires one argument (the query)
	})
end

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
			print("Selected file: " .. choice)
		end
	end)
end

return M
