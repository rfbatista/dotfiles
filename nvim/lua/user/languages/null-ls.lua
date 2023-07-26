local null_ls = require("null-ls")
local nls_utils = require "null-ls.utils"

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black.with { extra_args = { "--fast" } },
  },
  root_dir = nls_utils.root_pattern "node_modules",
})
