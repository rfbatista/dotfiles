local status_ok = pcall(require, "filetype")
if not status_ok then
	return
end

vim.g.did_load_filetypes = 1
