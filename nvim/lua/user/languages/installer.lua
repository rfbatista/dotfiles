local servers = {
	"pyright",
	"jsonls",
	"lua_ls",
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

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

require("mason").setup()
require("mason-lspconfig").setup()

local keymap = require("user.languages.lsp.keymap")
lspconfig.sumneko_lua.setup(require("user.languages.lua.sumneko"))
lspconfig.tsserver.setup(require("user.languages.typescript.tsserver"))
lspconfig.gopls.setup(require("user.languages.go.gopls"))
lspconfig.clangd.setup({
	on_attach = keymap.on_attach,
})
