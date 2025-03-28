local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.mapleader = "<Space>"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Explorer
-- keymap("n", "<Space><Tab>", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-Left>", ":bnext<CR>", opts)
keymap("n", "<S-Right>", ":bprevious<CR>", opts)
-- Go to previous edited buffer
keymap("n", "<A-p>", "<C-^>", opts)

-- Move text up and down
-- keymap("n", "<C-Up>", "<Esc>:m .-2<CR>==gi", opts)
-- keymap("n", "<C-Down>", "<Esc>:m .+1<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Keep current yank in register
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<C-Up>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<C-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)

keymap('n', '<Tab>', '<Cmd>Neotree reveal<CR>', opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap("n", "<A-2>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes'))<cr>", opts)
keymap("n", "<A-3>", "<cmd>lua require'telescope.builtin'.live_grep()<cr>", opts)
keymap("n", "<A-4>", "<cmd>lua require'telescope.builtin'.buffers()<cr>", opts)


-- Close buffers
keymap("n", "<A-k>", "<cmd>BufferCloseAllButCurrent<CR>", opts)
-- Buffers
keymap("n", "<A-q>", "<cmd>BufferClose<cr>", opts)
--[[ keymap("n", "<A-w>", ":BufferLineCycleNext<CR>", opts) ]]
--[[ keymap("n", "<A-e>", ":BufferLineCyclePrev<CR>", opts) ]]
keymap("n", "<A-w>", ":BufferNext<CR>", opts)
keymap("n", "<A-e>", ":BufferPrevious<CR>", opts)
-- Subsistitute

-- Clear Highlights
keymap("n", "<C-l>", ":noh<CR><CR>", opts)
 
