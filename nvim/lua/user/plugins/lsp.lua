return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"folke/neodev.nvim",
		{ "b0o/schemastore.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "HiPhish/rainbow-delimiters.nvim" },
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

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		--[[ require("neodev").setup() ]]

		--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
		--[[ capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) ]]

		local mason_lspconfig = require("mason-lspconfig")

		local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_status_ok then
			return
		end
		lspconfig.lua_ls.setup(require("user.languages.configs.sumneko"))
		--[[ lspconfig.gopls.setup(require("user.languages.configs.gopls")) ]]
		lspconfig.clangd.setup(require("user.languages.configs.cpp"))
		lspconfig.pyright.setup(require("user.languages.configs.python"))
		--[[ lspconfig.dartls.setup(require("user.languages.configs.dart")) ]]
		--[[ lspconfig.pyright.setup(require("user.languages.configs.python")) ]]
		--[[ lspconfig.sqls.setup(require("user.languages.configs.sql")) ]]

		-- Frontend
		--[[ lspconfig.templ.setup(require("user.languages.configs.templ")) ]]
		lspconfig.html.setup(require("user.languages.configs.html"))
		lspconfig.tailwindcss.setup(require("user.languages.configs.tailwind"))
		lspconfig.eslint.setup(require("user.languages.configs.eslint"))
		--[[ require("typescript").setup({ ]]
		--[[ disable_commands = false, -- prevent the plugin from creating Vim commands ]]
		--[[ debug = false,         -- enable debug logging for commands ]]
		--[[ go_to_source_definition = { ]]
		--[[ fallback = true,     -- fall back to standard LSP definition on failure ]]
		--[[ }, ]]
		--[[ server = require("user.languages.configs.tsserver"), ]]
		--[[ }) ]]
		--[[ lspconfig.tsserver.setup() ]]
		--[[ lspconfig.cssmodules_ls.setup(require("user.languages.configs.css")) ]]

		--[[ local js = require("user.languages.configs.javascript") ]]
		--[[ js.setup() ]]

		vim.diagnostic.config({
			title = false,
			underline = true,
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				source = "always",
				style = "minimal",
				border = "rounded",
				header = "",
				prefix = "",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
