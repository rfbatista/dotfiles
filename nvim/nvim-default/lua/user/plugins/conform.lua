return {
	"stevearc/conform.nvim",
	tag = "v9.0.0",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },

			go = { "goimports", "gofumpt", "golines" },
			templ = { "templ", "injected" },

			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			json = { "biome" },
			sql = { "sql_formatter" },

			sh = { "beautysh" },
			zsh = { "beautysh" },
		},
		format_on_save = {
			lsp_fallback = false,
			timeout_ms = 1000,
		},
		log_level = vim.log.levels.INFO,
		notify_on_error = true,
	},
}
