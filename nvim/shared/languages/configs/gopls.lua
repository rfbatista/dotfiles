local keymap = require("languages.lsp.keymap")

local util = require("lspconfig/util")

local M = {}

M.root_dir = util.root_pattern("go.work", "go.mod", ".git")

M.cmd = { "gopls" }

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr, { allowed_clients = { "gopls" }, format_on_save = true })
	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities and client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end

	-- auto organize imports
	-- require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
	-- require("navigator.dochighlight").documentHighlight(bufnr)
	-- require("navigator.codeAction").code_action_prompt(bufnr)
	-- vim.api.nvim_create_autocmd("BufWritePre", {
	-- 	pattern = "*.go",
	-- 	callback = function()
	-- 		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
	-- 	end,
	-- })
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
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
