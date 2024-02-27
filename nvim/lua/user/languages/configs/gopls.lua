local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	-- keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true })
	-- auto organize imports
	require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
	require("navigator.dochighlight").documentHighlight(bufnr)
	require("navigator.codeAction").code_action_prompt(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		end,
	})
end

M.filetypes = {
	"go",
}

M.settings = {
	gopls = {
		experimentalPostfixCompletions = true,
		analyses = {
			unusedparams = true,
			shadow = true,
		},
		staticcheck = true,
	},
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
