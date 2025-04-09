local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr)
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.js", "*.ts" },
		callback = function(ctx)
			client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
		end,
	})
end

return M
