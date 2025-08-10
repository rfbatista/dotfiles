return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    -- Simple configuration to attach to remote java debug process
    -- Taken directly from https://github.com/mfussenegger/nvim-dap/wiki/Java
  end,
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = { ensure_installed = {} },
    },
  },
}
