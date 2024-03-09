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

local diagnostics_trouble = {
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

local mappings = {
	D = Diagnostics.keymap,
	T = Typescript,
	r = diagnostics_trouble.keymap,
	["q"] = { "<cmd>q!<cr>", "Quit" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
}

return mappings
