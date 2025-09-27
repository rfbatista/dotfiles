local base = require("user.languages.lsp.keymap")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local mason_registry = require("mason-registry")

-- Ensure the package is installed before proceeding.
local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.signatureHelpProvider = false
	base.on_attach(client, bufnr)
end

M.capabilities = capabilities

if not mason_registry.has_package("bicep-lsp") then
	return M
end

-- Get the installed package object.
local bicep_pkg = mason_registry.get_package("bicep-lsp")

-- Construct the full path to the Bicep language server DLL. Adjust the relative
local bicep_lsp_bin = bicep_pkg:get_install_path() .. "/extension/bicepLanguageServer/Bicep.LangServer.dll"

local vim_notify = require("notify")
vim_notify(bicep_lsp_bin)

M.cmd = {
	"dotnet",
	bicep_lsp_bin,
}

return M
