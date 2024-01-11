local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
M.capabilities = capabilities
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
--[[ M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities) ]]
--[[ M.capabilities = require("cmp_nvim_lsp").default_capabilities() ]]

return M
