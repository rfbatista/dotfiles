local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
	require("navigator.dochighlight").documentHighlight(bufnr)
	require("navigator.codeAction").code_action_prompt(bufnr)
end

M.filetypes = {
	"templ",
	"css",
	"tsx",
	"jsx",
	"html",
	"hbs",
	"javascript",
	"typescript",
	"react",
	"handlebars",
}

return M
