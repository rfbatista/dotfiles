local keymap = require("user.languages.lsp.keymap")

local M = {}

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  keymap.on_attach(client, bufnr)
end

M.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.stdpath("config") .. "/lua"] = true,
      },
    },
          telemetry = {
        enable = false,
      },
  },
}

return M
