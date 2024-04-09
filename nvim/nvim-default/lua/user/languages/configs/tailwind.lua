local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
  keymap.on_attach(client, bufnr)
end

-- M.filetypes = {
-- 	"templ",
-- 	"css",
-- 	"tsx",
-- 	"jsx",
-- 	"html",
-- 	"hbs",
-- 	"javascript",
-- 	"typescript",
-- 	"react",
-- 	"handlebars",
-- }

return M
