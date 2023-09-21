local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.prettier,
  formatting.stylua,
  -- null_ls.builtins.diagnostics.pylint.with {
  --   diagnostics_postprocess = function(diagnostic)
  --     diagnostic.code = diagnostic.message_id
  --   end,
  -- },
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.black,
  lint.shellcheck,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
