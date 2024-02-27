local vim_notify = require("notify")

function _FORMAT_CODE()
	vim_notify("Formatando codigo...", "info")
	vim.lsp.buf.format()
	vim_notify("Codigo formatado", "info")
end

local Diagnostics = {
	keymap = {
		name = "Diagnostics",
		a = { "<cmd>TroubleToggle<cr>", "Toggle" },
		s = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
		q = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
		w = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
		e = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
		d = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
	},
}

local Golang = {
	keymap = {
		name = "Golang",
		a = { "<cmd>GoAddTag json<cr>", "Add json tags" },
		A = { "<cmd>GoRmTag json<cr>", "Remove json tags" },
		c = { "<cmd>GoRename<cr>", "Renomear variavel" },
		d = { "<cmd>GoFillStruct<cr>", "Auto fill struct" },
		e = { "<cmd>GoIfErr	<cr>", "Add if err" },
		f = { "<cmd>GoAddTag db<cr>", "Add db tags" },
		F = { "<cmd>GoRmTag db<cr>", "Remove db tags" },
		g = { "<cmd>GoImpl<cr>", "Implmenta interface" },
		h = { "<cmd>GoModTidy<cr>", "go mod tidy (restart)" },
		h = { "<cmd>GoModInit<cr>", "go mod init (restart)" },
	},
}

local Typescript = {
	name = "Typescript",
	b = { "<cmd>TSToolsOrganizeImports<CR>", "Organize imports" },
	c = { "<cmd>TSToolsRenameFile<CR>", "Typescript Rename File" },
	d = { "<cmd>TSToolsAddMissingImports<CR>", "Import all" },
	e = { "<cmd>TSToolsFixAll<CR>", "Fix all" },
	m = { "<cmd>TSToolsRemoveUnusedImports<CR>", "Remover imports nao utilizados" },
}

local function auto_update_path() end

function OpenNeoTree()
	-- local buf = vim.api.nvim_get_current_buf()
	-- local bufname = vim.api.nvim_buf_get_name(buf)
	-- if vim.fn.isdirectory(bufname) or vim.fn.isfile(bufname) then
	-- 	require("nvim-tree.api").tree.find_file(vim.fn.expand("%:p"))
	-- end
	vim.cmd("<cmd>Neotree reveal=true toggle<cr>")
end

local mappings = {
	D = Diagnostics.keymap,
	G = Golang.keymap,
	T = Typescript,
	a = require("user.tests.main").keymap,
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	r = require("user.interface.trouble").keymap,
	j = require("user.languages.configs.jsonls").keymap,
	m = require("user.languages.configs.plantuml").keymap,
	["M"] = { "<cmd>MarkdownPreview<cr>", "Open Markdown" },
	-- ["e"] = { "<cmd>lua OpenNeoTree()<cr>", "Explorer" },
	["q"] = { "<cmd>q!<cr>", "Quit" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["k"] = { "<cmd>BufferCloseAllButCurrent<CR>", "close all buffers" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	["u"] = { "<cmd>set noexpandtab<cr><cmd>retab!<cr>", "Spaces to Tabs" },
	["i"] = { "<cmd>set expandtab<cr><cmd>retab!<cr>", "Tabs to spaces" },

	n = {
		name = "Node",
		a = { "<cmd>2TermExec cmd='node %'<cr>", "Run current file" },
		b = { "<cmd>2TermExec cmd='npx ts-node-dev %'<cr>", "Run current file with typescript" },
	},

	g = {
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		f = { "<cmd>lua _FORMAT_CODE()<cr>", "Format" },
		h = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	p = {
		name = "Python",
		a = { "<cmd>2TermExec cmd='pipenv run python %'<cr>", "Run current file" },
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		b = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
		d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazy Docker" },
		e = { "<cmd>lua _START_NGROK()<cr>", "Start Ngrok" },
		f = { "<cmd>lua _OPEN_NGROK()<cr>", "Open Ngrok" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		l = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy Git" },
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		-- f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},

	o = {
		name = "DAP",
		a = { "<cmd>lua require('dapui').open()<cr>", "Open" },
		b = { "<cmd>lua require('dapui').close()<cr>", "Close" },
		c = { "<cmd>lua require('dapui').close()<cr>", "Toggle" },
		d = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		e = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
	},
}

return mappings
