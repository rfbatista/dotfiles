local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = {
	"pyright",
	"jsonls",
	"sumneko_lua",
	"gopls",
	"eslint",
	"tsserver",
	"ansiblels",
	"kotlin_language_server",
	"terraformls",
	"dockerls",
	"svelte",
}

-- setup pipenv 
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

lsp_installer.setup({
	ensure_installed = servers,
	ui = {
		border = "single",
	},
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.languages.lsp.keymap").on_attach,
		capabilities = require("user.languages.lsp.capabilities").capabilities,
	}
	if server == "pyright" then
		opts = require("user.languages.python.init")
	end
	if server == "sumneko_lua" then
		opts = require("user.languages.lua.sumneko")
	end
	if server == "kotlin_language_server" then
		opts = require("user.languages.kotlin.init")
	end
	if server == "tsserver" then
		opts = require("user.languages.typescript.tsserver")
	end
	if server == "eslint" then
		opts = require("user.languages.typescript.eslint")
	end
	if server == "gopls" then
		opts = require("user.languages.go.gopls")
	end
	if server == "svelte" then
		opts = require("user.languages.svelte.init")
	end
	lspconfig[server].setup(opts)
end
