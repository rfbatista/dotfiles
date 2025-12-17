return {
	{
		"<leader>Tb",
		function()
			LazyVim.lsp.action["source.organizeImports"]()
		end,
		desc = "Organize imports",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Td",
		function()
			LazyVim.lsp.action["source.addMissingImports.ts"]()
		end,
		desc = "Import all",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Te",
		function()
			vim.cmd("TSToolsFixAll")
		end,
		desc = "Fix all",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Tm",
		function()
			LazyVim.lsp.action["source.removeUnused.ts"]()
		end,
		desc = "Remover imports nao utilizados",
		nowait = true,
		remap = false,
	},
}
