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
		}

		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		require("mason-lspconfig").setup_handlers({
			["pyright"] = function()
				require("lspconfig").pyright.setup(require("user.lsp.keymap"))
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
