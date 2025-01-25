return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/prettier.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")

			local null_ls_utils = require("null-ls.utils")

			mason_null_ls.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"eslint_d", -- js linter
					"golangci_lint", -- go linter
					"terraform_fmt", -- terraform formatter
					"terraform_validate", -- terraform linter
					"shellcheck", -- shell linter
					"buf", -- buf formatter
					"gofumpt", -- go formatter "gofmt",
					"golines",
					"goimports_reviser",
					"yamlfmt", -- yaml formatter
					"goimports",
					"spell", -- spell checker
					"black",
					"blackd",
					"pylint",
					"djlint",
					"djhtml",
					-- "golangci_lint",
				},
			})

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),

				sources = {
					formatting.stylua,
					formatting.prettier,
					formatting.gofumpt,
					formatting.terraform_fmt,
					formatting.buf,
					formatting.yamlfmt,
					formatting.goimports,
					formatting.golines,
					formatting.goimports_reviser,
					formatting.black,
					formatting.sql_formatter,
					-- formatting.djhtml,
					-- The only way to configure the formatter is by using the provided config options, it will not pick up on config files.
					-- formatting.blackd,
					-- diagnostics.eslint_d,
					-- diagnostics.eslint_d.with({                                  -- js/ts linter
					--   condition = function(utils)
					--     return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
					--   end,
					-- }),
					-- diagnostics.golangci_lint,
					diagnostics.terraform_validate,
					diagnostics.yamllint,
					diagnostics.djlint,
					-- diagnostics.pylint,
					diagnostics.sqlfluff.with({
						extra_args = { "--dialect", "postgres" }, -- change to your dialect
					}),
					code_actions.gitsigns,
					code_actions.refactoring,
				},
			})
		end,
	},
}
