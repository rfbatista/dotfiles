local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local M = {}

M.capabilities = require("user.languages.lsp.capabilities").capabilities

return {
	"pmizio/typescript-tools.nvim",
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		require("typescript-tools").setup({
			capabilities = M.capabilities,
			on_attach = function(client, bufnr)
				local buf_map = function(_, mode, lhs, rhs, opts)
					vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
						silent = true,
					})
				end
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
				local ts_utils = require("nvim-lsp-ts-utils")
				ts_utils.setup({})
				ts_utils.setup_client(client)
				buf_map(bufnr, "n", "gs", ":TSToolsOrganizeImports<CR>")
				buf_map(bufnr, "n", "gi", ":TSToolsRenameFile<CR>")
				buf_map(bufnr, "n", "go", ":TSToolsAddMissingImports<CR>")
				vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
				vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
				vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
				vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
				vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
				vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
				vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
				vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
				vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
				vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
				vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
				vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
				vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
				buf_map(bufnr, "n", "gd", ":TSToolsGoToSourceDefinition<CR>")
				buf_map(bufnr, "n", "gr", ":LspRename<CR>")
				buf_map(bufnr, "n", "gs", ":TroubleToggle lsp_references<CR>")
				buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
				buf_map(bufnr, "n", "K", ":LspHover<CR>")
				buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
				buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
				buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
				buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
				-- buf_map(bufnr, "n", "<leader>z", "<cmd>lua vim.diagnostic.setloclist()<CR>")
				buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end,
			settings = {
				separate_diagnostic_server = true,
				expose_as_code_action = "all",
				-- tsserver_plugins = {},
				tsserver_max_memory = "auto",
				complete_function_calls = true,
				include_completions_with_insert_text = true,
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					includeCompletionsForModuleExports = true,
					quotePreference = "auto",
					-- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
				},
			},
		})
	end,
}
