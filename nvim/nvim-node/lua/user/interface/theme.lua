return {
  {
    "catppuccin/nvim",
    priority = 150,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        integration_default = false,
        integrations = {
          barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
          cmp = true,
          gitsigns = true,
          hop = true,
          illuminate = { enabled = true },
          native_lsp = { enabled = true, inlay_hints = { background = true } },
          neogit = true,
          neotree = true,
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,
          vimwiki = true,
          which_key = true,
          aerial = true,
          fidget = true,
          mason = true,
          neotest = true,
          dap_ui = true,
          telescope = {
            enabled = true,
            style = "nvchad"
          },
        },
      })
      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
}
