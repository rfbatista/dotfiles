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
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }) -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }) -- Useful lua functions used ny lots of plugins
	use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" })
	use({ "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352" })

	use("stevearc/dressing.nvim")

	-- use 'dylanaraps/wal.vim'

	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- Comments
	use({ "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" })

	-- Markdown
	-- to use :MarkdownPreview
	--[[ use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" }) ]]
  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		commit = "a52f078026b27694d2290e34efa61a6e4a690621",
	})

	-- Theme
	-- use "lunarvim/darkplus.nvim"
	-- use "projekt0n/github-nvim-theme"
	--[[ use({ "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }) ]]

	use({ "catppuccin/nvim", as = 'catppuccin' })
	-- use "sainnhe/everforest"

	-- snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.1.0" }) --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Editor configuration
	use({ "editorconfig/editorconfig-vim" })

	use({ "tpope/vim-surround", tag = "v2.2" })

	-- Prettier
	--[[ use("prettier/vim-prettier") ]]
	--[[ use("sbdchd/neoformat") ]]
	-- use "fsouza/prettierd"

	-- Fort HTML/React
	use("windwp/nvim-ts-autotag")

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- LSP
	--[[ use("williamboman/nvim-lsp-installer") -- simple to use language server installer ]]
	use({ "williamboman/mason.nvim", commit = "2469bfc2538652cb0cf88c129f67d38e46a9cb59" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "422b9745143150e16cd3fe331c74f6737de75e72" })
	use({ "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" }) -- enable LSP
	use({"jose-elias-alvarez/null-ls.nvim", commit = "647a1eeeefc43ce15d941972642210637c370471"})
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", commit = "0a6a16ef292c9b61eac6dad00d52666c7f84b0e7" })
	--[[ use({ "ray-x/lsp_signature.nvim", tag = "v0.2.0" }) ]]

	-- CPP
	--[[ use("p00f/clangd_extensions.nvim") ]]

	-- React
	--[[ use("MaxMEllon/vim-jsx-pretty") ]]

	-- Navigation
	use("justinmk/vim-sneak")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
	})
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		--[[ commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac", ]]
		run = ":TSUpdate",
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })

	use("p00f/nvim-ts-rainbow")
	--use 'nvim-telescope/telescope-media-files.nvim'

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

	-- buffer
	use({ "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })

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

	-- Faster nvim
	use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })

	-- Identation
	use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })

	-- JAVA
	use("mfussenegger/nvim-jdtls")

	-- Debugging
	use({ "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" })
	use({ "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	-- use({ "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" })
	use({ "theHamsta/nvim-dap-virtual-text" })
	use("nvim-telescope/telescope-dap.nvim")
	use({ "mfussenegger/nvim-dap-python" })

	use("nacro90/numb.nvim")

	use("declancm/cinnamon.nvim")

	-- Tags
	--[[ use("preservim/tagbar") ]]

	-- Waka time
	--[[ use("wakatime/vim-wakatime") ]]

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
	--[[ use("folke/todo-comments.nvim") ]]

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	--[[ use("plytophogy/vim-virtualenv") ]]
	--[[ use("PieterjanMontens/vim-pipenv") ]]

	--[[ use({ "ckipp01/stylua-nvim", run = "cargo install stylua" }) ]]
	-- use { "wellle/context.vim", branch = "master" }


  --[[ use("fatih/vim-go") ]]

  --[[ use("norcalli/nvim-colorizer") ]]
	--[[ use({ "mg979/vim-visual-multi", branch = "master" }) ]]

  use 'simrat39/rust-tools.nvim'
  --Work tree
	use("ThePrimeagen/harpoon")
  use 'ThePrimeagen/git-worktree.nvim'

  -- tests
  use {
    "klen/nvim-test",
    config = function()
      require('nvim-test').setup()
    end
  }

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
