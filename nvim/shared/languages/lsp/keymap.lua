local M = {}

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

M.buf_map = buf_map

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

-- restricted format
---@param bufnr number buffer to format
---@param allowed_clients string[] client names to allow formatting
local format_by_client = function(bufnr, allowed_clients)
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			if not allowed_clients then
				return true
			end
			return vim.tbl_contains(allowed_clients, client.name)
		end,
	})
end

local register_format_on_save = function(bufnr, allowed_clients)
	local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_group,
		buffer = bufnr,
		callback = function()
			format_by_client(bufnr, allowed_clients)
		end,
	})
end

-- local navic = require("nvim-navic")

local on_attach = function(client, bufnr, format_opts)
	if client.server_capabilities.documentSymbolProvider then
		-- navic.attach(client, bufnr)
	end
	if client.name == "jsonls" or client.name == "ansiblels" or client.name == "tsserver" or client.name == "html" then
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end
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
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
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
	lsp_highlight_document(client)
	if client.server_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
	-- if format_opts.format_on_save then
	-- 	register_format_on_save(bufnr, format_opts.allowed_clients or { client.name })
	-- end
end

--[[ local lsp_capabilities = require("cmp_nvim_lsp").server_capabilities() ]]

M = {
	on_attach = on_attach,
	--[[ lsp_capabilities = lsp_capabilities, ]]
}

return M
