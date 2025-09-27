local keymap = require("user.languages.lsp.keymap")

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "*.tf" },
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })

local M = {}

M.on_attach = function(client, bufnr)
  if vim.fn.expand("%:e") == "tfvars" then 
    vim.bo.filetype = "conf"
    return
  end
	keymap.on_attach(client, bufnr)
end

M.filetypes = { "terraform" , "hcl"}

M.flags = { debounce_text_changes = 150 }

return M
