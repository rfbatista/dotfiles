local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true })
	-- auto organize imports
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		end,
	})
end

return M
