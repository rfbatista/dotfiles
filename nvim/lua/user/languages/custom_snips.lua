local status_ok = pcall(require, "which-key")
if not status_ok then
	return
end

local luasnip = require("luasnip")
function _JESTER_DEBUG()
	local snip = luasnip.parser.parse_snippet("yer", "$1, err := $2($0); if err != nil { \n return err }")
	luasnip.snip_expand(snip)
end

local M = {
	keymap = {
		name = "Snips",
		a = {
			name = "Golang",
			a = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "$1, err := $2($0); if err != nil { \n return err \n }")
          luasnip.snip_expand(snip)
        end
        , "[DEBUG] Run test under cursor" },
		},
	},
}

return M

