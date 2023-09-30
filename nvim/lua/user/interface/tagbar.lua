-- local status_ok, tagbar = pcall(require, "tagbar")
-- if not status_ok then
--   return
-- end

vim.g["tagbar_ctags_bin"] = '$HOME/dotfiles/ctags/ctags'
vim.g["tagbar_left"] = 1
vim.g["tagbar_show_linenumbers"] = 1
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<F8>", ":TagbarToggle<CR>", opts)
keymap("n", "<C-m>", ":TagbarJumpNext<CR>", opts)
keymap("n", "<C-n>", ":TagbarJumpPrev<CR>", opts)
