local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return { keymap = {} }
end

trouble.setup()

local M = {
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

return M
