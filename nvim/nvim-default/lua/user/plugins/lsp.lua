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
		{ "b0o/schemastore.nvim" },
		{ "ray-x/navigator.lua" },
		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		"ray-x/go.nvim",
		"ray-x/guihua.lua",
		"nvim-treesitter/nvim-treesitter",
		"akinsho/flutter-tools.nvim",
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		"pmizio/typescript-tools.nvim",
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
			"templ",
			"htmx",
			"tailwindcss",
			"cssls",
			"rust_analyzer",
			"sqls",
			"terraformls",
			"hcl",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		require("mason-lspconfig").setup_handlers({
			["tsserver"] = function()
				-- require("lspconfig").tsserver.setup(require("user.languages.configs.tsserver"))
			end,
			["sqlls"] = function()
				require("lspconfig").sqlls.setup(require("user.languages.configs.sql"))
			end,
			["cssls"] = function()
				require("lspconfig").cssls.setup(require("user.languages.configs.css"))
			end,
			["pyright"] = function()
				require("lspconfig").pyright.setup(require("user.languages.configs.python"))
			end,
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup(require("user.languages.configs.sumneko"))
			end,
			["gopls"] = function()
				require("lspconfig").gopls.setup(require("user.languages.configs.gopls"))
			end,
			["jsonls"] = function()
				require("lspconfig").jsonls.setup({
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,
			["html"] = function()
				require("lspconfig").html.setup(require("user.languages.configs.html"))
			end,
			-- ["dartls"] = function()
			-- 	require("lspconfig").dartls.setup(require("user.languages.configs.dart"))
			-- end,
			["templ"] = function()
				require("lspconfig").templ.setup(require("user.languages.configs.templ"))
			end,
			["htmx"] = function()
				require("lspconfig").htmx.setup(require("user.languages.configs.htmx"))
			end,
			["tailwindcss"] = function()
				require("lspconfig").tailwindcss.setup(require("user.languages.configs.tailwind"))
			end,
			["zls"] = function()
				require("lspconfig").zls.setup(require("user.languages.configs.zig"))
			end,
			["terraformls"] = function()
				require("lspconfig").terraformls.setup(require("user.languages.configs.terraformls"))
			end,
			["hcl"] = function()
				require("lspconfig").hcl.setup(require("user.languages.configs.hcl"))
			end,
			["clangd"] = function()
				require("lspconfig").clangd.setup(require("user.languages.configs.clangd"))
			end,
			["bicep"] = function()
				require("lspconfig").bicep.setup(require("user.languages.configs.bicep"))
			end,
		})

		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
				require("user.languages.lsp.keymap").on_attach(client, bufnr)
			end,
		})

		require("go").setup()

		local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})

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
