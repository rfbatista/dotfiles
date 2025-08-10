return {
  -- Core LSP and Mason
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "nvim-java/nvim-java",
      version = "2.1.1",
    },
    {
      "mason-org/mason.nvim",
      opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      version = "1.31.0",
    },
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
		require("mason-lspconfig").setup({
			ensure_installed = { "jdtls" },
		})
		local openjdk_path = "/usr/lib/jvm/java-24-openjdk" -- Ensure this path is correct for your system.
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
    require("java").setup({})

  end,
}
