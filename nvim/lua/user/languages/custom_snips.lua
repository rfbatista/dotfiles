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
			name = "NodeJs",
			a = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "const $1 = $2 \n if($1.isFailure()) return $1 as Result<Error> \n const $0 = $1.getValue() as $3")
          luasnip.snip_expand(snip)
        end
        , "Verificar Result" },
		},
		b = {
			name = "Golang",
			a = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "$1, err := $2($0); if err != nil { \n return err \n }")
          luasnip.snip_expand(snip)
        end
        , "If error" },
		},
		c = {
			name = "PlantUML",
			a = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "@startuml\n@enduml")
          luasnip.snip_expand(snip)
        end
        , "Start" },
			f = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "entity $0 {\n}")
          luasnip.snip_expand(snip)
        end
        , "Entity" },
			b = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", "frame $0 {\n}")
          luasnip.snip_expand(snip)
        end
        , "Frame" },
			c = {
        function ()
          local snip = luasnip.parser.parse_snippet("yer", 'node "$0"')
          luasnip.snip_expand(snip)
        end
        , "Node" },
		},
	},
}

return M
