local servers = {
	"pyright",
	"jsonls",
	"lua_ls",
	"gopls",
	"clangd",
	"tsserver",
	"kotlin_language_server",
	"terraformls",
	"dockerls",
	"sqls",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup()

lspconfig.sumneko_lua.setup(require("user.languages.configs.sumneko"))
lspconfig.tsserver.setup(require("user.languages.configs.tsserver"))
lspconfig.gopls.setup(require("user.languages.configs.gopls"))
lspconfig.clangd.setup(require("user.languages.configs.cpp"))
lspconfig.html.setup(require("user.languages.configs.html"))
lspconfig.pyright.setup(require("user.languages.configs.python"))
lspconfig.sqls.setup(require("user.languages.configs.sql"))
