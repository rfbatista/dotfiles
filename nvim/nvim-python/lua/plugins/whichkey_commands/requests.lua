return {
	{
		"<leader>R",
		group = "Requests",
		nowait = true,
		remap = false,
	},

	{
		"<leader>Ra",
		"<cmd>lua require('kulala').run()<cr>",
		desc = "Run request",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Rb",
		"<cmd>lua require('kulala').toggle_view()<cr>",
		desc = "Toggle between body and headers",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Rd",
		"<cmd>lua require('kulala').run()<cr>",
		desc = "Run under cursor request",
		nowait = true,
		remap = false,
	},
	{
		"<leader>Ri",
		"<cmd>lua require('kulala').inspect()<cr>",
		desc = "Inspect current request",
		nowait = true,
		remap = false,
	},
}
