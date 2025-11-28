return {
	{
		"<leader>ai",
		function()
			require("tests.main").integration_test()
		end,
		desc = "Run nearest integrations test",
	},
}
