return {
	{
		"<leader>m",
		group = "Tests",
		nowait = true,
		remap = false,
	},
	{
		"<leader>mi",
		function()
			require("tests.main").integration_test()
		end,
		desc = "Run nearest integrations test",
	},
	{
		"<leader>ma",
		'<cmd>lua require("neotest").run.run()<cr>',
		desc = "Run the nearest test",
		nowait = true,
		remap = false,
	},
	{
		"<leader>mb",
		"<cmd>lua require('neotest').summary.toggle()<cr>",
		desc = "Show tests summary",
		nowait = true,
		remap = false,
	},
	{
		"<leader>mo",
		'<cmd>lua require("neotest").output.open({ enter = true, auto_close = true })<cr>',
		desc = "Show Output",
		nowait = true,
		remap = false,
	},

	{
		"<leader>md",
		"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
		desc = "Debug the nearest test",
		nowait = true,
		remap = false,
	},
}
