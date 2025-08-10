-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autocmds using vim.api.nvim_create_autocmd

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autocmds using vim.api.nvim_create_autocmd

-- To list all options available run :help options
local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  guifont = "JetBrains Mono:h17", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

local general_augroup = vim.api.nvim_create_augroup("_general_settings", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = "if &readonly | set noreadonly | endif",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "exec 'setlocal lcs=tab:\\▎\\ '",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "man", "lspinfo" },
  group = general_augroup,
  command = "nnoremap <silent> <buffer> q :close<CR>",
})

-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   group = general_augroup,
--   callback = function()
--     require('vim.highlight').on_yank({ higroup = 'Visual', timeout = 200 })
--   end,
-- })

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  group = general_augroup,
  command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  group = general_augroup,
  command = "set nobuflisted",
})

local git_augroup = vim.api.nvim_create_augroup("_git", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  group = git_augroup,
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  group = git_augroup,
  command = "setlocal spell",
})

local markdown_augroup = vim.api.nvim_create_augroup("_markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = markdown_augroup,
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = markdown_augroup,
  command = "setlocal spell",
})

local auto_resize_augroup = vim.api.nvim_create_augroup("_auto_resize", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  group = auto_resize_augroup,
  command = "tabdo wincmd =",
})

local alpha_augroup = vim.api.nvim_create_augroup("_alpha", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  group = alpha_augroup,
  callback = function()
    vim.opt.showtabline = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      group = alpha_augroup,
      command = "set showtabline=2",
    })
  end,
})
