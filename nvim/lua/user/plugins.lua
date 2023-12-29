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
  use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself

  ---------------
  -- Interface --
  ---------------
  use("nvim-lua/popup.nvim")                                                           -- An implementation of the Popup API from vim in Neovim
  use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }) -- Useful lua functions used ny lots of plugins
  use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" })
  use({ "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" })
  use("stevearc/dressing.nvim")
  use("brenoprata10/nvim-highlight-colors")
  -- Menus and submodes
  use("anuvyklack/hydra.nvim")
  use({
    "SmiteshP/nvim-navic",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  -- Notificacoes
  use("rcarriga/nvim-notify")
  -- Comments
  use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })
  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    commit = "a52f078026b27694d2290e34efa61a6e4a690621",
  })
  -- Theme
  -- use "lunarvim/darkplus.nvim"
  -- use "projekt0n/github-nvim-theme"
  use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" })
  use("catppuccin/nvim")

  ---------------
  -- Commands --
  ---------------
  use({ "tpope/vim-surround", tag = "v2.2" })
  -- Navigation
  use("justinmk/vim-sneak")
  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    tag = "0.1.5",
  })
  use("nvim-telescope/telescope-media-files.nvim")
  use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })
  -- Git
  -- Gitsigns
  use({ "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" })
  use("tpope/vim-fugitive")

  -- Nvim Tree
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
  })
  -- Whick key
  use("folke/which-key.nvim")
  -- Projects
  use({ "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" })

  -- Terminal
  use({ "akinsho/toggleterm.nvim", commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" })

  -- Dashboard
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31",
  })
  -- Identation
  use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })
  use("nacro90/numb.nvim")
  use({ "mg979/vim-visual-multi", branch = "master" })
  use("ThePrimeagen/harpoon")
  use("romgrk/barbar.nvim")
  use("famiu/bufdelete.nvim")

  ---------------
  -- Languages --
  ---------------
  -- Markdown
  -- to use :MarkdownPreview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  -- snippets
  use({ "L3MON4D3/LuaSnip", tag = "v1.1.0" }) --snippet engine
  use("rafamadriz/friendly-snippets")        -- a bunch of snippets to use
  -- Editor configuration
  use({ "editorconfig/editorconfig-vim" })
  -- Fort HTML/React
  use("windwp/nvim-ts-autotag")

  --- TYPESCRIPT
  use({ "jose-elias-alvarez/typescript.nvim" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" })        -- The completion plugin
  use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })      -- buffer completions
  use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" })        -- path completions
  use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
  use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use({ "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12" })
  use({ "williamboman/mason-lspconfig.nvim", commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c" })
  use({ "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }) -- enable LSP
  use("jose-elias-alvarez/null-ls.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  --[[ use("p00f/nvim-ts-rainbow") ]]
  use({ "HiPhish/rainbow-delimiters.nvim", tag = "v0.3.0" })
  --use 'nvim-telescope/telescope-media-files.nvim'

  use({
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup()
    end,
  })

  -- Tags
  use("preservim/tagbar")

  -- Waka time
  use("wakatime/vim-wakatime")

  -- Trouble
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

  use({ "mvllow/modes.nvim", tag = "v0.2.0" })
  use({ "kevinhwang91/promise-async" })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  use("nvim-tree/nvim-web-devicons") -- OPTIONAL: for file icons

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
  use("Mofiqul/dracula.nvim")
end)
