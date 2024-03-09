M = {}

M.setup = function()
	vim.g.htl_css_templates = 1
	vim.g.htl_all_templates = 1
	vim.g.closetag_filetypes = "html,xhtml,phtml,javascript,typescript"
	vim.g.closetag_regions = {
		["typescript.tsx"] = "jsxRegion,tsxRegion,litHtmlRegion",
		["javascript.jsx"] = "jsxRegion,litHtmlRegion",
		["javascript"] = "litHtmlRegion",
		["typescript"] = "litHtmlRegion",
	}
end

return M
