return {
	"weirongxu/plantuml-previewer.vim",
	dependencies = {
		"aklt/plantuml-syntax",
		"tyru/open-browser.vim",
	},
	config = function()
		vim.g.plantuml_viewer = "open-browser"
		-- vim.g.plantuml_viewer_options = {
		-- 	open_browser = {
		-- 		browser = "chrome",
		-- 	},
		-- }
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "plantuml",
			callback = function()
				local handle = io.popen("cat `which plantuml` | grep plantuml")
				if handle then
					local result = handle:read("*a")
					handle:close()
					local jar_path = result:match("['\"]?(%S+plantuml%.jar)")
					if jar_path then
						vim.g["plantuml_previewer#plantuml_jar_path"] = jar_path
					end
				end
			end,
		})
	end,
}
