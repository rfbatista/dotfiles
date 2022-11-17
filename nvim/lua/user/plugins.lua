local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("That didnt work")
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("kyazdani42/nvim-web-devicons")
  use("stevearc/dressing.nvim")

  -- use 'dylanaraps/wal.vim'

  use({
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- Comments
  use { "numToStr/Comment.nvim", tag = 'v0.7.0', } -- Easily comment stuff

  -- Markdown
  -- to use :MarkdownPreview
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" })

  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  -- Theme
  -- use "lunarvim/darkplus.nvim"
  -- use "projekt0n/github-nvim-theme"
  use "folke/tokyonight.nvim"
  -- use("catppuccin/nvim")
  -- use "sainnhe/everforest"

  -- snippets
  use { "L3MON4D3/LuaSnip", tag = "v1.1.0" } --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- Editor configuration
  use{ "editorconfig/editorconfig-vim", }

  use{ "tpope/vim-surround", tag = "v2.2" }

  use("windwp/nvim-autopairs")

  -- Prettier
  use("prettier/vim-prettier")
  use("sbdchd/neoformat")
  -- use "fsouza/prettierd"

  -- Fort HTML/React
  use("windwp/nvim-ts-autotag")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")

  -- LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use{ "neovim/nvim-lspconfig", tag = "v0.1.3" } -- enable LSP
  use("tamago324/nlsp-settings.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use{ "ray-x/lsp_signature.nvim", tag = "v0.2.0" }

  -- CPP
  use("p00f/clangd_extensions.nvim")

  -- React
  use("MaxMEllon/vim-jsx-pretty")

  -- Navigation
  use("justinmk/vim-sneak")

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use("nvim-telescope/telescope-media-files.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("p00f/nvim-ts-rainbow")
  --use 'nvim-telescope/telescope-media-files.nvim'

  -- Gitsigns
  use("lewis6991/gitsigns.nvim")

  use("tpope/vim-fugitive")

  -- Nvim Tree
  use { "kyazdani42/nvim-tree.lua", requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
    tag = 'nightly' }

  -- buffer
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")

  -- Whick key
  use("folke/which-key.nvim")

  -- Projects
  use("ahmedkhalf/project.nvim")

  -- Terminal
  use("akinsho/toggleterm.nvim")

  -- Dashboard
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  -- Faster nvim
  use("lewis6991/impatient.nvim")

  -- Identation
  use("lukas-reineke/indent-blankline.nvim")

  -- Debugging
  use({ "mfussenegger/nvim-dap", tag = '0.1.0' })
  use({ "mfussenegger/nvim-dap-python" })
  use({ "rcarriga/nvim-dap-ui", tag = 'v1.1.1' })
  use({ "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" })
  use({ "theHamsta/nvim-dap-virtual-text" })
  use("nvim-telescope/telescope-dap.nvim")

  use("nacro90/numb.nvim")

  use("declancm/cinnamon.nvim")

  -- Tags
  use("preservim/tagbar")

  -- Waka time
  use("wakatime/vim-wakatime")

  -- Trouble
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

  -- Filetype
  use("nathom/filetype.nvim")

  use("David-Kunz/jester")

  -- Languages pack
  -- use("sheerun/vim-polyglot")

  -- Plant UML
  use("aklt/plantuml-syntax")
  use("tyru/open-browser.vim")
  use("weirongxu/plantuml-previewer.vim")

  -- Todo
  use("folke/todo-comments.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  use("plytophogy/vim-virtualenv")
  use("PieterjanMontens/vim-pipenv")

  use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })
  -- use { "wellle/context.vim", branch = "master" }

  use('ThePrimeagen/harpoon')

  use { 'mg979/vim-visual-multi', branch = 'master' }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
