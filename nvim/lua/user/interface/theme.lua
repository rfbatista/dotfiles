-- vim.cmd [[
--   " Important!!
--   if has('termguicolors')
--     set termguicolors
--   endif
--   " For dark version.
--   set background=dark
--   " For light version.
--   "" set background=light
--   " Set contrast.
--   " This configuration option should be placed before `colorscheme everforest`.
--   " Available values: 'hard', 'medium'(default), 'soft'
--   let g:everforest_background = 'hard'
--   " For better performance
--   let g:everforest_better_performance = 1
--   let g:everforest_transparent_background = 0
--   let g:everforest_current_word = 'bold'
--   colorscheme everforest
-- ]]

-- require('github-theme').setup({
--   theme_style = "dark",
-- })

require("tokyonight.colors").setup({})
--
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
--
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--
vim.cmd[[colorscheme tokyonight]]


-- require('everforest').setup({
-- })

-- local catppuccin = require("catppuccin")

-- configure it
-- catppuccin.setup({})

-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.cmd[[colorscheme catppuccin]]
