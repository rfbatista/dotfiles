local keymap = require("user.languages.lsp.keymap")

local M = {}

-- M.on_init = function(_, config)
-- 	config.settings.python.pythonPath = get_python_path(config.root_dir)
-- end

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

M.on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            lsp_formatting(bufnr)
        end,
    })
  end
  keymap.on_attach(client, bufnr)
end

M.settings = {
	python = {
     analysis = {
      typeCheckingMode = "off",
    },
  },
}

return M
