local keymap = require("user.languages.lsp.keymap")

local M = {}

-- M.on_init = function(_, config)
-- 	config.settings.python.pythonPath = get_python_path(config.root_dir)
-- end

M.on_attach = keymap.on_attach

M.settings = {}

return M
