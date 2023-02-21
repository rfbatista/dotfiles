local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

--[[ vim.lsp.set_log_level("debug") ]]

require("user.languages.installer")
require("user.languages.tests")
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

