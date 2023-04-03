local servers = {
	"pyright",
	"jsonls",
  "rust_analyzer",
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
	automatic_installation = false,
	ensure_installed = servers,
})

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

--[[ local rt = require("rust-tools") ]]
--[[]]
--[[ rt.setup({ ]]
--[[ 	server = { ]]
--[[ 		on_attach = require("user.languages.providers.rust.init").on_attach, ]]
--[[ 		settings = { ]]
--[[ 			["rust-analyzer"] = { ]]
--[[ 				inlayHints = { locationLinks = false }, ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ }) ]]

local opts = {}

opts = require("user.languages.providers.lua.init")
lspconfig.sumneko_lua.setup(opts)

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.languages.lsp.keymap").on_attach,
		capabilities = require("user.languages.lsp.capabilities").capabilities,
	}
	if server == "pyright" then
		opts = require("user.languages.providers.python.init")
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
	if server == "rust_analyzer" then
		opts = require("user.languages.providers.rust.init")
	end
	lspconfig[server].setup(opts)
end
