local M = {}

M.setup = {}

function _PLANTUML_SAVE_PDF()
	local location = vim.api.nvim_buf_get_name(0)
  location = string.gsub(location, ".uml", "")
  location = location .. ".pdf"
  print("Saving", location)
	return vim.api.nvim_command(table.concat({ "PlantumlSave", location }, " "))
end

M.keymap = {
	name = "Plant UML",
	a = { [[<cmd>PlantumlOpen<cr>]], "Start Plant UML" },
	s = { [[<cmd>PlantumlSave<cr>]], "Save PNG" },
	p = { [[<cmd>lua _PLANTUML_SAVE_PDF()<cr>]], "Save PDF" },
	d = { [[<cmd>PlantumlStop<cr>]], "Stop" },
}

return M
