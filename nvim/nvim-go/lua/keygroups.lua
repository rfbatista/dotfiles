local wk = require("which-key")
wk.add({
	{
		"<leader>t",
		group = "terminal",
		nowait = true,
		remap = false,
	}, --  terminal
	{ "<leader>l", group = "LSP" }, 
	{ "<leader>G", group = "Golang" }, 
	{ "<leader>g", group = "Git" }, 
	{ "<leader>d", group = "Diagnostics" }, 
})
