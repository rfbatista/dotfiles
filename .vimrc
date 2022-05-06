set cmdheight=2
set encoding=UTF-8

call plug#begin()
Plug 'ryanoasis/vim-devicons'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
" Typescript
Plug 'leafgarland/typescript-vim'
" Python
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Mofiqul/dracula.nvim'
call plug#end()
colorscheme dracula

" Vim commentary
nnoremap <C-m> :g/TODO/Commentary

" Airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'

" Nerdtree keys
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Editor config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Ale
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers['javascript'] = ['eslint']
" Fix files automatically on save
let g:ale_fix_on_save = 1
