local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = { "jsonls", "sumneko_lua", "eslint" }

lsp_installer.setup {
  ensure_installed = servers
}

local keymap = require("user.lsp.keymap")
local default_server_config = {
  on_attach = keymap.on_attach
}

local server_configs = {
  -- Use null_ls for formatting
  gopls = require("user.lsp.settings.gopls"),
  jsonls = require("lsp.jsonls").config,
  -- Conflicts with prettier formatting in TS files.
  sumneko_lua = require("user.lsp.settings.sumneko_lua"),
  tsserver = require("user.lsp.settings.tsserver").config,
  bashls = default_server_config,
  cssls = default_server_config,
  eslint = require("user.lsp.settings.eslint"),
  yamlls = require("user.lsp.settings.yamlls"),
}

local lspconfig = require("lspconfig")

local function setup_lsp_servers()
  for server_name, server_config in pairs(server_configs) do
    lspconfig[server_name].setup(server_config)
  end
end

setup_lsp_servers()

require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})
