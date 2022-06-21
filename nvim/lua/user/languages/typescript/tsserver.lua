local keymap = require("user.languages.lsp.keymap")

local M = {}

-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  local ts_utils = require("nvim-lsp-ts-utils")
  ts_utils.setup({})
  ts_utils.setup_client(client)
  buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
  buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
  buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
  keymap.on_attach(client, bufnr)
end

M.settings = {
  codeAction = {
    disableRuleComment = {
      enable = true,
      location = "separateLine"
    },
    showDocumentation = {
      enable = true
    }
  },
  codeActionOnSave = {
    enable = false,
    mode = "all"
  },
  format = true,
  nodePath = "",
  onIgnoredFiles = "off",
  packageManager = "npm",
  quiet = false,
  rulesCustomizations = {},
  run = "onType",
  useESLintClass = false,
  validate = "on",
  workingDirectory = {
    mode = "location"
  }
}

return M
