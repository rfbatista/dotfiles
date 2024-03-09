return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    function ADD_TAGS()
      vim.ui.select({ "json", "db" }, {
        prompt = "Add tag to struct",
        telescope = require("telescope.themes").get_cursor(),
      }, function(selected)
          vim.cmd("GoTagAdd " .. selected)
        end)
    end

    function RM_TAGS()
      vim.ui.select({ "json", "db" }, {
        prompt = "Add tag to struct",
        telescope = require("telescope.themes").get_cursor(),
      }, function(selected)
          vim.cmd("GoTagRm " .. selected)
        end)
    end

    function IMPL_INTERFACE()
      vim.ui.select({ "json", "db" }, {
        prompt = "Interface name",
        telescope = require("telescope.themes").get_cursor(),
      }, function(selected)
          vim.cmd("GoImpl " .. selected)
        end)
    end
   
    local wk = require("which-key")
    wk.register({
      ["q"] = { "<cmd>q!<cr>", "Quit" },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      t = { "<cmd>lua ADD_TAGS()<CR>", "Add tags" },
      T = { "<cmd>lua RM_TAGS()<CR>", "Remove tags" },
      i = { "<cmd>lua IMPL_INTERFACE()<CR>", "Implement interface" },
      a = { "<cmd>GoTestAdd<CR>", "Add test for function" },
      b = { "<cmd>GoTestAll<CR>", "Add test for all functions in file" },
      c = { "<cmd>GoTestExp<CR>", "Add test for all exported functions in file" },
    }, { prefix = "<leader>" })
  end,
}

