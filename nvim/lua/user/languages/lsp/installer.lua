local servers = {
	"pyright",
	"jsonls",
	"sumneko_lua",
	"gopls",
	-- "eslint",
	"tsserver",
	"ansiblels",
	"kotlin_language_server",
	"terraformls",
	"dockerls",
	"svelte",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

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
		opts = require("user.languages.python.init")
	end
	if server == "sumneko_lua" then
		opts = require("user.languages.lua.sumneko")
	end
	if server == "kotlin_language_server" then
		opts = require("user.languages.kotlin.init")
	end
	if server == "tsserver" then
		opts = require("user.languages.typescript.tsserver")
	end
	-- if server == "eslint" then
	-- 	opts = require("user.languages.typescript.eslint")
	-- end
	if server == "gopls" then
		opts = require("user.languages.go.gopls")
	end
	if server == "svelte" then
		opts = require("user.languages.svelte.init")
	end
	lspconfig[server].setup(opts)
end
