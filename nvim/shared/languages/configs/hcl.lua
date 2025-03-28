
local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
	keymap.on_attach(client, bufnr)
end

M.filetypes = { "hcl" }

return M
