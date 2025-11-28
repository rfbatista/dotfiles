return {
	{
		"<leader>fs",
		function()
			require("ai.ai").send_file()
		end,
		desc = "Send file",
		mode = { "n" },
	},
	{
		"<leader>fs",
		function()
			require("ai.ai").send_selection()
		end,
		desc = "Send selection",
		mode = { "v" },
	},
	{
		"<leader>fl",
		function()
			require("ai.ai").show_session_picker()
		end,
		desc = "List templates",
	},
	{
		"<leader>fd",
		function()
			require("ai.ai").delete_session()
		end,
		desc = "Delete session",
	},
	{
		"<leader>fo",
		function()
			require("ai.ai").toggle()
		end,
		desc = "Open aider",
	},
}
