return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	lazy = true,
	opts = {
		defaults = {
			["<leader>t"] = { name = "terminal" },
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		show_help = true, -- show help message on the command line when the popup is visible
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
	},
	keys = {
		{
			"<leader>q",
			"<cmd>q!<cr>",
			desc = "Quit",
			mode = "n",
		},
		{
			"<leader>w",
			"<cmd>w!<CR>",
			desc = "Save",
			mode = "n",
		},

		-- terminal
		{
			"<leader>t",
			group = "terminal",
			nowait = true,
			remap = false,
		}, -- group
		{
			"<leader>tb",
			"<cmd>ToggleTerm direction=tab<cr>",
			desc = "Tab",
			group = "terminal",
		},
		{
			"<leader>td",
			"<cmd>lua _LAZYDOCKER_TOGGLE()<cr>",
			desc = "Lazy Docker",
			group = "terminal",
		},
		{
			"<leader>te",
			"<cmd>lua _START_NGROK()<cr>",
			desc = "Start Ngrok",
			group = "terminal",
		},
		{
			"<leader>tf",
			"<cmd>lua _OPEN_NGROK()<cr>",
			desc = "Open Ngrok",
			group = "terminal",
		},
		{
			"<leader>tu",
			"<cmd>lua _NCDU_TOGGLE()<cr>",
			desc = "NCDU",
			group = "terminal",
		},
		{
			"<leader>tt",
			"<cmd>lua _HTOP_TOGGLE()<cr>",
			desc = "Htop",
			group = "terminal",
		},
		{
			"<leader>tp",
			"<cmd>lua _PYTHON_TOGGLE()<cr>",
			desc = "Python",
			group = "terminal",
		},
		{
			"<leader>tl",
			"<cmd>lua _LAZYGIT_TOGGLE()<cr>",
			desc = "Lazy Git",
			group = "terminal",
		},
		{
			"<leader>tn",
			"<cmd>lua _NODE_TOGGLE()<cr>",
			desc = "Node",
			group = "terminal",
		},
		{
			"<leader>th",
			"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
			desc = "Horizontal",
			group = "terminal",
		},
		{
			"<leader>tv",
			"<cmd>ToggleTerm size=80 direction=vertical<cr>",
			desc = "Vertical",
			group = "terminal",
		},

		-- LSP
		{ "<leader>l", group = "lsp" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{ "<leader>lf", "<cmd>lua _FORMAT_CODE()<cr>", desc = "Format" },
		{ "<leader>lh", "<cmd>Telescope lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
		{ "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
		{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
		{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
		{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

		-- Golang
		{
			"<leader>Ga",
			"<cmd>GoAddTag json<cr>",
			desc = "Add json tags",
			mode = "n",
		},
		{
			"<leader>GA",
			"<cmd>GoRmTag json<cr>",
			desc = "Remove json tags",
			mode = "n",
		},
		{
			"<leader>Gb",
			"<cmd>GoAddTag form<cr>",
			desc = "Add form tags",
			mode = "n",
		},
		{
			"<leader>GB",
			"<cmd>GoRmTag form<cr>",
			desc = "Remove form tags",
			mode = "n",
		},
		{
			"<leader>Gc",
			"<cmd>GoRename<cr>",
			desc = "Rename variable",
			mode = "n",
		},
		{
			"<leader>Gd",
			"<cmd>GoFillStruct<cr>",
			desc = "Auto fill struct",
			mode = "n",
		},
		{
			"<leader>Ge",
			"<cmd>GoIfErr<cr>",
			desc = "Add if err",
			mode = "n",
		},
		{
			"<leader>Gf",
			"<cmd>GoAddTag db<cr>",
			desc = "Add db tags",
			mode = "n",
		},
		{
			"<leader>GF",
			"<cmd>GoRmTag db<cr>",
			desc = "Remove db tags",
			mode = "n",
		},
		{
			"<leader>Gg",
			"<cmd>GoImpl<cr>",
			desc = "Implement interface",
			mode = "n",
		},
		{
			"<leader>Gh",
			"<cmd>GoModTidy<cr>",
			desc = "Go mod tidy (restart)",
			mode = "n",
		},
		{
			"<leader>GH",
			"<cmd>GoModInit<cr>",
			desc = "Go mod init (restart)",
			mode = "n",
		},
		{
			"<leader>Gi",
			"<cmd>GoAddTag param<cr>",
			desc = "Add param tags",
			mode = "n",
		},
		{
			"<leader>GI",
			"<cmd>GoRmTag param<cr>",
			desc = "Remove param tags",
			mode = "n",
		},

		-- Git
		{
			"<leader>gj",
			"<cmd>lua require 'gitsigns'.next_hunk()<cr>",
			desc = "Next Hunk",
			mode = "n",
		},
		{
			"<leader>gk",
			"<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
			desc = "Prev Hunk",
			mode = "n",
		},
		{
			"<leader>gg",
			"<cmd>lua _LAZYGIT_TOGGLE()<CR>",
			desc = "Lazygit",
			mode = "n",
		},
		{
			"<leader>gl",
			"<cmd>lua require 'gitsigns'.blame_line()<cr>",
			desc = "Blame",
			mode = "n",
		},
		{
			"<leader>gp",
			"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
			desc = "Preview Hunk",
			mode = "n",
		},
		{
			"<leader>gr",
			"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
			desc = "Reset Hunk",
			mode = "n",
		},
		{
			"<leader>gR",
			"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
			desc = "Reset Buffer",
			mode = "n",
		},
		{
			"<leader>gs",
			"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
			desc = "Stage Hunk",
			mode = "n",
		},
		{
			"<leader>gu",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
			mode = "n",
		},
		{
			"<leader>go",
			"<cmd>Telescope git_status<cr>",
			desc = "Open changed file",
			mode = "n",
		},
		{
			"<leader>gb",
			"<cmd>Telescope git_branches<cr>",
			desc = "Checkout branch",
			mode = "n",
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<cr>",
			desc = "Checkout commit",
			mode = "n",
		},
		{
			"<leader>gd",
			"<cmd>Gitsigns diffthis HEAD<cr>",
			desc = "Diff",
			mode = "n",
		},

		-- Diagnostics
		{
			"<leader>da",
			"<cmd>TroubleToggle<cr>",
			desc = "Toggle",
			mode = "n",
		},
		{
			"<leader>ds",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics",
			mode = "n",
		},
		{
			"<leader>dq",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			desc = "Document Diagnostics",
			mode = "n",
		},
		{
			"<leader>dw",
			"<cmd>TroubleToggle quickfix<cr>",
			desc = "Quickfix",
			mode = "n",
		},
		{
			"<leader>de",
			"<cmd>TroubleToggle loclist<cr>",
			desc = "Loclist",
			mode = "n",
		},
		{
			"<leader>dd",
			"<cmd>TroubleToggle lsp_references<cr>",
			desc = "LSP References",
			mode = "n",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.add({
			{ "<leader>D", group = "Diagnostics", nowait = true, remap = false },
		})
		wk.setup(opts)
	end,
}
