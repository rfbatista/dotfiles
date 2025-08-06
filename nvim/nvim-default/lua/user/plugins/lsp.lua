return {
	-- Core LSP and Mason
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- { "nvim-java/nvim-java", tag = "v2.1.2" },
		-- { "mfussenegger/nvim-jdtls", tag = "0.2.0" },
		{ "virchau13/tree-sitter-astro" },
		-- Mason and LSP installer
		{ "williamboman/mason.nvim", config = true, tag = "v2.0.0" },
		{ "williamboman/mason-lspconfig.nvim", tag = "v2.0.0" },

		-- LSP UI/UX
		{ "j-hui/fidget.nvim", opts = {} },
		"folke/neodev.nvim",
		{ "b0o/schemastore.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		-- { "HiPhish/rainbow-delimiters.nvim" },
		{ "ray-x/navigator.lua" },
		{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
		"nvim-treesitter/nvim-treesitter",
		"akinsho/flutter-tools.nvim",
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
		-- Language-specific
		"ray-x/go.nvim",
	},
	config = function()
		local function setup_diagnostic_signs()
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end

		local function setup_diagnostics()
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
		end
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
		-- require("mason-lspconfig").setup({
		-- 	ensure_installed = servers,
		-- })

		-- LSP server handlers
		local lsp_handlers = {
			["sqlls"] = function()
				require("lspconfig").sqlls.setup(require("user.languages.configs.sql"))
			end,
			["pyright"] = function()
				require("lspconfig").pyright.setup(require("user.languages.configs.pyright"))
			end,
			["astro"] = function()
				require("lspconfig").astro.setup(require("user.languages.configs.astro"))
			end,
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup(require("user.languages.configs.sumneko"))
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
			["jinja_lsp"] = function()
				require("lspconfig").jinja_lsp.setup(require("user.languages.configs.jinja"))
			end,
			["terraformls"] = function()
				require("lspconfig").terraformls.setup(require("user.languages.configs.terraformls"))
			end,
			["clangd"] = function()
				require("lspconfig").clangd.setup(require("user.languages.configs.clangd"))
			end,
			["yamlls"] = function()
				require("lspconfig").yamlls.setup(require("user.languages.configs.yamlls"))
			end,
		}

		for _, handler in pairs(lsp_handlers) do
			handler()
		end

		-- Autocommands
		local function setup_autocmds()
			-- Disable hover for Ruff
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
					end
				end,
				desc = "LSP: Disable hover capability from Ruff",
			})

			-- Go import formatting
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end

		-- Setup diagnostics and signs
		setup_diagnostics()
		setup_diagnostic_signs()
		setup_autocmds()
	end,
}
