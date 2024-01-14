return {
	"ggandor/leap.nvim",
	dependencies = { { "tpope/vim-repeat" } },
	config = function()
		require("leap").create_default_mappings()
		require("leap").init_highlight(true)
	end,
}
