local keymap = require("user.languages.lsp.keymap")

local M = {}

M.capabilities = require("user.languages.lsp.capabilities").capabilities

M.on_attach = function(client, bufnr)
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
	-- local ts_utils = require("nvim-lsp-ts-utils")
	-- ts_utils.setup({})
	-- ts_utils.setup_client(client)
	-- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
	-- buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
	-- buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
	-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	-- if client.supports_method("textDocument/formatting") then
	-- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 	vim.api.nvim_create_autocmd("BufWritePre", {
	-- 		group = augroup,
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			lsp_formatting(bufnr)
	-- 		end,
	-- 	})
	-- end
	keymap.on_attach(client, bufnr)
end
return M
