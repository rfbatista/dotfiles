local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	sources = {
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
	},
})
