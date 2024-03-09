local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end


local on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
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

vim.cmd("command! LspTelescopeRef lua require'telescope.builtin'.lsp_references{}")
	vim.cmd("command! LspTelescopeImpl lua require'telescope.builtin'.lsp_implementations{}")

  -- go to definition
	buf_map(bufnr, "n", "gd", ":LspTelescopeRef<CR>")

  -- go to implementation
	buf_map(bufnr, "n", "gi", ":LspTelescopeImpl<CR>")

  -- rename
	buf_map(bufnr, "n", "gr", ":LspRename<CR>")

  -- acoes
	buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")

  -- tipagem
	buf_map(bufnr, "n", "K", ":LspHover<CR>")


  -- diagnostico
	buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
	buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")

	lsp_highlight_document(client)
	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return {
	"williamboman/mason.nvim", 
  dependencies = {
		"williamboman/mason-lspconfig.nvim",
  },
  config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local servers = {
			"jsonls",
			"tsserver",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})
    local navic = require("nvim-navic")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    capabilities.textDocument.completion.completionItem.snippetSupport = true   
		require("mason-lspconfig").setup_handlers({
			["tsserver"] = function()
				require("lspconfig").tsserver.setup({
          on_attach = function(client, bufnr)
            		navic.attach(client, bufnr)
                on_attach(client, bufnr)
          end,
          capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				require("lspconfig").jsonls.setup({
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,
		})

  end
}
