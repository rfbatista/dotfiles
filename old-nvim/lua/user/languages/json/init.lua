-- Need to install JQ
-- https://stedolan.github.io/jq/
local M = {
	keymap = {
		name = "JSON",
		a = { [[<cmd>%!jq<cr>]], "JSON pretty" },
		r = { [[<cmd>%!jq -c<cr>]], "JSON one line" },
	},
}

return M
