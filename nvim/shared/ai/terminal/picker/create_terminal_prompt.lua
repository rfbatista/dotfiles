local M = {}

local create_named = require("ai.terminal.named.create_named")

---Create terminal with name prompt
function M.create_terminal_prompt()
	vim.ui.input({
		prompt = "Terminal name: ",
		default = "",
	}, function(name)
		if name and name ~= "" then
			vim.ui.input({
				prompt = "Command (empty for shell): ",
				default = vim.o.shell,
			}, function(cmd)
				create_named.create_named(name, cmd or vim.o.shell)
			end)
		end
	end)
end

return M