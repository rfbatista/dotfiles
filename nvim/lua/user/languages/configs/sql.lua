local keymap = require("user.languages.lsp.keymap")

local M = {}

--[[ M.cmd = { '/home/renan/dotfiles/lsp/lua-language-server' } ]]

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr)
end

M.settings = {
	sqls = {
		connections = {
			{
				driver = "sqlite3",
				dataSourceName = "database",
			},
		},
	},
}

return M
