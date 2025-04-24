return {
	"GeorgesAlkhouri/nvim-aider",
	cmd = "Aider",
	-- Example key mappings for common actions:
	dependencies = {
		"folke/snacks.nvim",
		--- The below dependencies are optional
		"catppuccin/nvim",
		"nvim-tree/nvim-tree.lua",
		--- Neo-tree integration
		keys = {
			{ "<A-f>", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			opts = function(_, opts)
				-- Example mapping configuration (already set by default)
				-- opts.window = {
				--   mappings = {
				--     ["+"] = { "nvim_aider_add", desc = "add to aider" },
				--     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
				--     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
				--   }
				-- }
				require("nvim_aider.neo_tree").setup(opts)
			end,
		},
	},
	config = true,
}
