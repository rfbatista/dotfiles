local keymap = require("user.languages.lsp.keymap")
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")

local M = {}

M.on_attach = keymap.on_attach

--[[ M.filetype = { "py", "python" } ]]
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities = capabilities

--[[ M.rootdir = function(fname) ]]
--[[ 	return lspconfig.util.find_git_ancestor(fname) ]]
--[[ end ]]
M.on_new_config = function(cfg, root)
	print(root)
end

M.settings = {}

return M
