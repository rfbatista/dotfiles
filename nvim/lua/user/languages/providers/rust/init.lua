local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = keymap.on_attach

M.cmd = {
  "rustup", "run", "stable", "rust-analyzer",
}

return M
