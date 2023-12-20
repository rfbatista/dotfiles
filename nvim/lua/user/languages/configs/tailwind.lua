local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = keymap.on_attach

M.filetypes = {
	"templ",
	"tsx",
	"jsx",
	"html",
  "hbs",
  "handlebars",
}

return M
