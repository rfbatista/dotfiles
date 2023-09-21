local configs = require "plugins.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "clangd",
  "lua_ls",
  "pyright",
  "tsserver",
}

local lua = require "custom.configs.lsp-config.lua"

for _, lsp in ipairs(servers) do
  local conf = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if lsp == "lua_ls" then
    conf = require "custom.configs.lsp-config.lua"
  elseif lsp == "pyright" then
    conf = require "custom.configs.lsp-config.python"
  elseif lsp == "tsserver" then
    conf = require "custom.configs.lsp-config.node"
  end
  lspconfig[lsp].setup(conf)
end
