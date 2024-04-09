return {
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "renerocksai/calendar-vim" },
	config = function()
		require("telekasten").setup({
			home = vim.fn.expand("$HOME/projetos/notes/"), -- Put the name of your notes directory here
		})
	end,
}
