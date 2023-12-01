local configs = require("lspconfig.configs")

configs.templ = {
	default_config = {
		--[[ cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/Users/adrian/templ.log" }, ]]
		filetypes = { "templ" },
		settings = {},
	},
}

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
	"templ",
	"ruff_lsp",
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
	ensure_installed = servers,
})
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "delve", "cppdbg", "node2" },
	automatic_installation = true,
})
lspconfig.sumneko_lua.setup(require("user.languages.configs.sumneko"))
lspconfig.tsserver.setup(require("user.languages.configs.tsserver"))
lspconfig.gopls.setup(require("user.languages.configs.gopls"))
lspconfig.clangd.setup(require("user.languages.configs.cpp"))
lspconfig.html.setup(require("user.languages.configs.html"))
lspconfig.pyright.setup(require("user.languages.configs.python"))
--[[ lspconfig.pyright.setup(require("user.languages.configs.python")) ]]
--[[ lspconfig.sqls.setup(require("user.languages.configs.sql")) ]]
lspconfig.templ.setup(require("user.languages.configs.templ"))
js = require("user.languages.configs.javascript")
js.setup()

