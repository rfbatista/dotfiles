return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<A-1>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
    vim.api.nvim_set_keymap(
      "n",
      "<A-0>",
      "<cmd>ToggleTerm 1 size=20 direction=float name=desktop<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<A-9>",
      "<cmd>ToggleTerm 2 size=20 direction=float name=teste<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<A-8>",
      "<cmd>ToggleTerm 3 size=20 direction=float name=teste<CR>",
      { noremap = true, silent = true }
    )

    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "n", "<S-t>", ":ToggleTerm<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-Right>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-Down>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-Up>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-Left>", [[<C-\><C-n><C-W>l]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-n>", [[2<C-\>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

    function _NCDU_TOGGLE()
      ncdu:toggle()
    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    local python = Terminal:new({ cmd = "python", hidden = true })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

    function _LAZYDOCKER_TOGGLE()
      lazydocker:toggle()
    end

    function _START_NGROK()
      vim.ui.input({ prompt = "Para qual porta mapear o ngrok?" }, function(str)
        local command =
            string.format('3TermExec cmd="ngrok http --host-header=rewrite http://localhost:%s"', str)
        vim.cmd(command)
      end)
    end

    function _OPEN_NGROK()
      local command = string.format("ToggleTerm 3")
      vim.cmd(command)
    end
  end,
}
