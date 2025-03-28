local keymap = require("user.languages.lsp.keymap")
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

local M = {}

M.on_attach = keymap.on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
M.capabilities = capabilities
M.cmd = { "zls" }
M.root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git")
M.single_file_support = true

return M
