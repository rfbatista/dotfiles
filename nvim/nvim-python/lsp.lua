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
		"ray-x/guihua.lua",
		"nvim-treesitter/nvim-treesitter",
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
			"jsonls",
			"tsserver",
      "jsonls",
			"terraformls",
			"dockerls",
			"sqls",
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		require("mason-lspconfig").setup_handlers({
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
		})

		require("typescript-tools").setup({
			-- disable_commands = false, -- prevent the plugin from creating Vim commands
			-- debug = false, -- enable debug logging for commands
			-- go_to_source_definition = {
			-- 	fallback = true, -- fall back to standard LSP definition on failure
			-- },
			-- server = {
			-- 	copabilities = require("user.languages.lsp.capabilities").capabilities,
			-- },
			on_attach = function(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
				require("user.lsp.keymap").on_attach(client, bufnr)
			end,
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
