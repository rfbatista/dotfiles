return {
	"nvim-java/nvim-java",
	config = function()
		local openjdk_path = "/usr/lib/jvm/java-24-openjdk" -- Ensure this path is correct for your system.

		-- Ensure Mason and Mason-LSPConfig are setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "jdtls" },
		})

		-- Load nvim-lspconfig and configure jdtls for Java
		local lspconfig = require("lspconfig")
		lspconfig.jdtls.setup({
			-- Insert any custom jdtls settings here, for example:
			cmd = {
				openjdk_path .. "/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"-Xmx2G",
				"-jar",
				vim.fn.glob(vim.fn.expand("~/.local/share/nvim-default/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")),
				"-configuration",
				vim.fn.expand("~/.local/share/nvim-default/mason/packages/jdtls/config_linux"),
				"-data",
				vim.fn.expand("~/.jdtls-workspace"),
			},
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
