return {
  "ThePrimeagen/harpoon",
  config = function()
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    --Remap space as leader key
    keymap("", "<Space>", "<Nop>", opts)
    -- Harpoon
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    })
    keymap("n", "<A-a>", "<cmd>lua require('harpoon.mark').add_file()<cr>", opts)
    keymap("n", "<A-c>", "<cmd>lua require('harpoon.mark').clear()<cr>", opts)
    keymap("n", "<A-s>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
  end,
}
