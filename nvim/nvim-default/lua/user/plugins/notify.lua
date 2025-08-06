return {
	{
		"rcarriga/nvim-notify",
    tag = "v3.15.0",
		config = function()
			local nvim_notify = require("notify")
			nvim_notify.setup({
				background_colour = "#000000",
			})
		end,
	},
}
