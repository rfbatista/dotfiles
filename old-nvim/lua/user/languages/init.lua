local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local settings = {
	ui = {
		border = "none",
		icons = {
      package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup{
  ensure_installed = { "sumneko_lua", "rust_analyzer" },
 }

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- vim.lsp.set_log_level("debug")

require("user.languages.installer")
require("user.languages.handlers").setup()
require "user.languages.null-ls"
require "user.languages.signature"
require "user.languages.cmp"
require "user.languages.treesitter"

vim.g["prettier#autoformat_config_present"] = 1

local status_ok, jester = pcall(require, "jester")
if not status_ok then
  return
end

jester.setup({
  dap = {
    cmd = "'$path_to_jest' '$file' -t '$result' ",
    console = "externalTerminal",
    path_to_jest_run = './node_modules/bin/jest',
    path_to_jest_debug = './node_modules/bin/jest'
  }
})

