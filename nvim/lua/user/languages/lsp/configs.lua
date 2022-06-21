local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local server_configs = {
  -- Use null_ls for formatting
  -- gopls = require("user.lsp.settings.gopls"),
  -- jsonls = require("lsp.jsonls").config,
  -- Conflicts with prettier formatting in TS files.
  sumneko_lua = require("user.languages.lua.sumneko"),
  tsserver = require("user.languages.typescript.tsserver").config,
  -- bashls = default_server_config,
  -- cssls = default_server_config,
  -- eslint = require("user.lsp.settings.eslint"),
  -- yamlls = require("user.lsp.settings.yamlls"),
}

local function setup_lsp_servers()
  for server_name, server_config in pairs(server_configs) do
    lspconfig[server_name].setup(server_config)
  end
end

setup_lsp_servers()
