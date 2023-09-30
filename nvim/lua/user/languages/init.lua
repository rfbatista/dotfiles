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

require "user.languages.lsp"
require "user.languages.typescript.jester"
require "user.languages.cmp"
require "user.languages.prettier"
require "user.languages.treesitter"
