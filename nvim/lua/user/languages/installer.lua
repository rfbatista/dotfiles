local configs = require("lspconfig.configs")

configs.templ = {
  default_config = {
    --[[ cmd = { "templ", "lsp", "-http=localhost:7474", "-log=/Users/adrian/templ.log" }, ]]
    filetypes = { "templ" },
    settings = {},
  },
}

local servers = {
  "pyright",
  "jsonls",
  "lua_ls",
  "gopls",
  "clangd",
  "tsserver",
  "kotlin_language_server",
  "terraformls",
  "dockerls",
  "sqls",
  "templ",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  ensure_installed = servers,
})
require("mason-lspconfig").setup()
lspconfig.sumneko_lua.setup(require("user.languages.configs.sumneko"))
lspconfig.gopls.setup(require("user.languages.configs.gopls"))
lspconfig.clangd.setup(require("user.languages.configs.cpp"))
lspconfig.pyright.setup(require("user.languages.configs.python"))
--[[ lspconfig.pyright.setup(require("user.languages.configs.python")) ]]
--[[ lspconfig.sqls.setup(require("user.languages.configs.sql")) ]]

-- Frontend
lspconfig.templ.setup(require("user.languages.configs.templ"))
lspconfig.html.setup(require("user.languages.configs.html"))
lspconfig.tailwindcss.setup(require("user.languages.configs.tailwind"))
require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false,           -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true,       -- fall back to standard LSP definition on failure
  },
  server = require("user.languages.configs.tsserver"),
})
--[[ lspconfig.tsserver.setup() ]]
--[[ lspconfig.cssmodules_ls.setup(require("user.languages.configs.css")) ]]

js = require("user.languages.configs.javascript")
js.setup()

-- FOLD
--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
--[[ capabilities.textDocument.foldingRange = { ]]
--[[     dynamicRegistration = false, ]]
--[[     lineFoldingOnly = true ]]
--[[ } ]]
--[[ local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'} ]]
--[[ for _, ls in ipairs(language_servers) do ]]
--[[     require('lspconfig')[ls].setup({ ]]
--[[         capabilities = capabilities ]]
--[[         -- you can add other fields for setting up lsp server in this table ]]
--[[     }) ]]
--[[ end ]]
--[[ require('ufo').setup() ]]
--[[]]

