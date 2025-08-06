return {
	"nvim-java/nvim-java",
	config = function()
		-- Ensure Mason and Mason-LSPConfig are setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "jdtls" },
		})

		-- Load nvim-lspconfig and configure jdtls for Java
		local lspconfig = require("lspconfig")
		lspconfig.jdtls.setup({
			-- Insert any custom jdtls settings here, for example:
			cmd = { "jdtls" },
			on_attach = function(client, bufnr)
				-- any further keybindings or options specific to Java can be set here
			end,
			-- other configuration options...
		})

		-- Setup nvim-java plugin with any desired custom configuration
		require("java").setup({
			-- Your custom nvim-java configuration goes here.
		})
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
}
