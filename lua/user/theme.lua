vim.cmd [[ 
  " Important!!
  if has('termguicolors')
    set termguicolors
  endif
  " For dark version.
  set background=dark
  " For light version.
  "" set background=light
  " Set contrast.
  " This configuration option should be placed before `colorscheme everforest`.
  " Available values: 'hard', 'medium'(default), 'soft'
  let g:everforest_background = 'hard'
  " For better performance
  let g:everforest_better_performance = 1
  let g:everforest_transparent_background = 0
  let g:everforest_current_word = 'bold'
  colorscheme everforest
]]

-- require('evenforest').setup({
-- })

