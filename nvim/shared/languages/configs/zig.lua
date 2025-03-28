local keymap = require("user.languages.lsp.keymap")
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

local M = {}

-- TODO:
-- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings
-- nvim_lsp.rust_analyzer.setup {
--   on_init = function(client)
--     client.config.settings.xxx = "yyyy"
--     client.notify("workspace/didChangeConfiguration")
--     return true
--   end
-- }

M.on_attach = keymap.on_attach

--[[ M.filetype = { "py", "python" } ]]
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
M.capabilities = capabilities
M.cmd = { "zls" }
M.root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git")
M.single_file_support = true

--[[ M.rootdir = function(fname) ]]
--[[ 	return lspconfig.util.find_git_ancestor(fname) ]]
--[[ end ]]

-- M.settings = {
-- 	python = {
-- 		analysis = {
-- 			completeFunctionParens = true,
-- 			useLibraryCodeForTypes = true,
-- 		},
-- 	},
-- }

return M
