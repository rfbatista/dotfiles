local null_ls = require("null-ls")
local keymap = require('user.languages.lsp.keymap')

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
  on_attach = keymap.on_attach
})
