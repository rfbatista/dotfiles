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

M.capabilities = keymap.lsp_capabilities

--[[ M.rootdir = function(fname) ]]
--[[ 	return lspconfig.util.find_git_ancestor(fname) ]]
--[[ end ]]
M.on_new_config = function(cfg, root)
	print(root)
end

M.settings = {
	python = {
		analysis = {
			completeFunctionParens = true,
			useLibraryCodeForTypes = true,
		},
	},
}

return M
