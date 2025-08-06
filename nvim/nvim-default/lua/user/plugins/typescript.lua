return {
	"pmizio/typescript-tools.nvim",
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
				require("user.languages.lsp.keymap").on_attach(client, bufnr)
			end,
		})
		require("lspconfig").tailwindcss.setup(require("user.languages.configs.tailwind"))
		require("lspconfig").htmx.setup(require("user.languages.configs.htmx"))
		require("lspconfig").eslint.setup(require("user.languages.configs.eslint"))
		require("lspconfig").html.setup(require("user.languages.configs.html"))
		require("lspconfig").cssls.setup(require("user.languages.configs.css"))
	end,
}
