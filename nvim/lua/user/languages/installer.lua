local servers = {
	"pyright",
	"jsonls",
	"gopls",
	"tsserver",
	"ansiblels",
	"kotlin_language_server",
	"terraformls",
	"dockerls",
	"svelte",
  "graphql",
}

--[[ require("nvim-lsp-installer").setup {} ]]
require("mason").setup(settings)
require("mason-lspconfig").setup({
	automatic_installation = true,
  ensure_installed = servers,
})

local settings = {
	ui = {
		border = "none",
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    }
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end


local opts = {}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.languages.lsp.keymap").on_attach,
		capabilities = require("user.languages.lsp.capabilities").capabilities,
	}
	if server == "pyright" then
		opts = require("user.languages.providers.python.init")
	end
	if server == "sumneko_lua" then
		opts = require("user.languages.providers.lua.init")
	end
  if server == "lua-language-server" then
		opts = require("user.languages.providers.lua.init")
	end
	if server == "kotlin_language_server" then
		opts = require("user.languages.providers.kotlin.init")
	end
	if server == "tsserver" then
		opts = require("user.languages.providers.typescript.tsserver")
	end
	if server == "svelte" then
		opts = require("user.languages.providers.svelte.init")
	end
	if server == "prisma-language-server" then
		opts = require("user.languages.providers.prisma.init")
	end
	lspconfig[server].setup(opts)
end
