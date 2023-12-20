local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettierd,
    formatting.stylua,
    diagnostics.eslint_d,
    --[[ code_actions.eslint_d, ]]
    formatting.clang_format,
    formatting.sqlfluff.with({
      --[[ extra_args = { "--dialect", "postgres" }, -- change to your dialect ]]
    }),
    formatting.black,
  },
  --[[ on_attach = function(client, bufnr) ]]
  --[[   if client.supports_method("textDocument/formatting") then ]]
  --[[     vim.api.nvim_clear_autocmds({ ]]
  --[[       group = augroup, ]]
  --[[       buffer = bufnr, ]]
  --[[     }) ]]
  --[[     vim.api.nvim_create_autocmd("BufWritePre", { ]]
  --[[       group = augroup, ]]
  --[[       buffer = bufnr, ]]
  --[[       callback = function() ]]
  --[[         vim.lsp.buf.format({ bufnr = bufnr }) ]]
  --[[       end, ]]
  --[[     }) ]]
  --[[   end ]]
  --[[ end, ]]
})
