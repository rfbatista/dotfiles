set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
" set noswapfile            " disable creating swap file
set showmatch               " show matching 
set hlsearch                " highlight search 
set incsearch               " incremental search
set number                  " add line numbers
syntax on                   " syntax highlighting
set tabstop=2 " set display width of tab; 1 tab = x space with                                                           
set expandtab " transform tab to x space (x is tabstop)                                                               
set autoindent " auto indent; new line with number of space at the beginning same as previous                                                                      
set shiftwidth=2 " number of space append to lines when type >> 
set number relativenumber

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" STATUS LINE
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these

" KEYS DEFINITIONS
Plug 'folke/which-key.nvim'

" NOTIFICATIONS
Plug 'rcarriga/nvim-notify'

" DASHBOARD
Plug 'glepnir/dashboard-nvim'

Plug 'kyazdani42/nvim-web-devicons'

" TREE SITER
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'Mofiqul/dracula.nvim'
call plug#end()
colorscheme dracula

" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Nerdtree keys
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" LUA Configurations

lua << END
vim.notify = require("notify")

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
})

require("which-key").setup {}
END
