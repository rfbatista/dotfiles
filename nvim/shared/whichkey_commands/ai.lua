return {
	{
		"<leader>a",
		group = "AI",
		nowait = true,
		remap = false,
	},
	{
		"<leader>as",
		function()
			require("ai.ai").send_file()
		end,
		desc = "Send file",
		mode = { "n" },
	},
	{
		"<leader>aS",
		function()
			require("ai.ai").send_selection()
		end,
		desc = "Send selection",
		mode = { "v" },
	},
	{
		"<leader>ao",
		function()
			require("ai.ai").toggle()
		end,
		desc = "Open",
	},
	{
		"<leader>at",
		function()
			require("ai.ai").list_tabs()
		end,
		desc = "Tabs",
	},
	{
		"<leader>aT",
		function()
			require("ai.ai").create_or_select_tab()
		end,
		desc = "Create or Select Tab",
	},
}
