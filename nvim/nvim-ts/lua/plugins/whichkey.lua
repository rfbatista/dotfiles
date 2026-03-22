-- Import whichkey commands
local tui_commands = require("plugins.whichkey_commands.tui")
local json_commands = require("plugins.whichkey_commands.json")
-- local typescript_commands = require("plugins.whichkey_commands.typescript")
local others_commands = require("plugins.whichkey_commands.others")
local ai_commands = require("plugins.whichkey_commands.ai")
local lsp_commands = require("plugins.whichkey_commands.lsp")
local git_commands = require("plugins.whichkey_commands.git")
local requests_commands = require("plugins.whichkey_commands.requests")
local terminal_commands = require("plugins.whichkey_commands.terminal")

-- Combine all imported commands
local function combine_tables(...)
  local result = {}
  for _, tbl in ipairs({ ... }) do
    for _, v in ipairs(tbl) do
      table.insert(result, v)
    end
  end
  return result
end

-- All keys combined
local keys = combine_tables(
  tui_commands,
  json_commands,
  -- typescript_commands,
  others_commands,
  ai_commands,
  lsp_commands,
  git_commands,
  requests_commands,
  terminal_commands,
  {
    -- Local keys
    {
      "<leader>Da",
      "<cmd>TroubleToggle<cr>",
      desc = "Toggle",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Dd",
      "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
      desc = "LSP References",
      nowait = true,
      remap = false,
    },
    {
      "<leader>De",
      "<cmd>TroubleToggle loclist<cr>",
      desc = "Loclist",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Dq",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "Document Diagnostics",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Ds",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      desc = "Workspace Diagnostics",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Dw",
      "<cmd>TroubleToggle quickfix<cr>",
      desc = "Quickfix",
      nowait = true,
      remap = false,
    },
    {
      "<leader>GA",
      "<cmd>GoRmTag json<cr>",
      desc = "Remove json tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>GB",
      "<cmd>GoRmTag form<cr>",
      desc = "Remove form tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>GF",
      "<cmd>GoRmTag db<cr>",
      desc = "Remove db tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>GI",
      "<cmd>GoRmTag param<cr>",
      desc = "Remove param tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Ga",
      "<cmd>GoAddTag json<cr>",
      desc = "Add json tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gb",
      "<cmd>GoAddTag form<cr>",
      desc = "Add form tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gc",
      "<cmd>GoRename<cr>",
      desc = "Renomear variavel",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gd",
      "<cmd>GoFillStruct<cr>",
      desc = "Auto fill struct",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Ge",
      "<cmd>GoIfErr\t<cr>",
      desc = "Add if err",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gf",
      "<cmd>GoAddTag db<cr>",
      desc = "Add db tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gg",
      "<cmd>GoImpl<cr>",
      desc = "Implmenta interface",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gh",
      "<cmd>GoModInit<cr>",
      desc = "go mod init (restart)",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Gi",
      "<cmd>GoAddTag param<cr>",
      desc = "Add param tags",
      nowait = true,
      remap = false,
    },
    {
      "<leader>M",
      "<cmd>MarkdownPreview<cr>",
      desc = "Open Markdown",
      nowait = true,
      remap = false,
    },
    {
      "<leader>P",
      "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
      desc = "Projects",
      nowait = true,
      remap = false,
    },
    {
      "<leader>aa",
      '<cmd>lua require("neotest").run.run()<cr>',
      desc = "Run the nearest test",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ab",
      "<cmd>lua require('neotest').summary.toggle()<cr>",
      desc = "Show tests summary",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ac",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
      desc = "Run all tests in file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ao",
      '<cmd>lua require("neotest").output.open({ enter = true, auto_close = true })<cr>',
      desc = "Show Output",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ad",
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      desc = "Debug the nearest test",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ai",
      "<cmd>lua Integration_test()<cr>",
      desc = "Run current integration test file",
      nowait = true,
      remap = false,
    },
    {
      "<leader>c",
      "<cmd>Bdelete!<CR>",
      desc = "Close Buffer",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Da",
      "<cmd>lua require('kulala').run()<cr>",
      desc = "Run request",
      nowait = true,
      remap = false,
    },
    {
      "<leader>Rb",
      "<cmd>Rest open<cr>",
      desc = "Open result pane",
      nowait = true,
      remap = false,
    },
    {
      "<leader>h",
      "<cmd>nohlsearch<CR>",
      desc = "No Highlight",
      nowait = true,
      remap = false,
    },
    {
      "<leader>i",
      "<cmd>set expandtab<cr><cmd>retab!<cr>",
      desc = "Tabs to spaces",
      nowait = true,
      remap = false,
    },
    {
      "<leader>k",
      "<cmd>BufferCloseAllButCurrent<CR>",
      desc = "close all buffers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ma",
      "<cmd>PlantumlOpen<cr>",
      desc = "Start Plant UML",
      nowait = true,
      remap = false,
    },
    {
      "<leader>md",
      "<cmd>PlantumlStop<cr>",
      desc = "Stop",
      nowait = true,
      remap = false,
    },
    {
      "<leader>mp",
      "<cmd>lua _PLANTUML_SAVE_PDF()<cr>",
      desc = "Save PDF",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ms",
      "<cmd>PlantumlSave<cr>",
      desc = "Save PNG",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oa",
      "<cmd>lua require('dapui').open()<cr>",
      desc = "Open",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ob",
      "<cmd>lua require('dapui').close()<cr>",
      desc = "Close",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oc",
      "<cmd>lua require('dapui').close()<cr>",
      desc = "Toggle",
      nowait = true,
      remap = false,
    },
    {
      "<leader>od",
      "<cmd>lua require('dap').toggle_breakpoint()<cr>",
      desc = "Toggle Breakpoint",
      nowait = true,
      remap = false,
    },
    {
      "<leader>oe",
      "<cmd>lua require('dapui').eval()<cr>",
      desc = "Eval",
      nowait = true,
      remap = false,
    },
    {
      "<leader>of",
      "<cmd>lua require('dap').clear_breakpoints()<cr>",
      desc = "Clear ALL Breakpoints",
      nowait = true,
      remap = false,
    },
    {
      "<leader>os",
      "<cmd>lua require('dap').continue()<cr>",
      desc = "Start",
      nowait = true,
      remap = false,
    },
    {
      "<leader>q",
      "<cmd>q!<cr>",
      desc = "Quit",
      nowait = true,
      remap = false,
    },
    {
      "<leader>ra",
      "<cmd>TroubleToggle<cr>",
      desc = "Toggle",
      nowait = true,
      remap = false,
    },
    {
      "<leader>rd",
      "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
      desc = "LSP References",
      nowait = true,
      remap = false,
    },
    {
      "<leader>re",
      "<cmd>TroubleToggle loclist<cr>",
      desc = "Loclist",
      nowait = true,
      remap = false,
    },
    {
      "<leader>rq",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Document Diagnostics",
      nowait = true,
      remap = false,
    },
    {
      "<leader>rs",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Workspace Diagnostics",
      nowait = true,
      remap = false,
    },
    {
      "<leader>rw",
      "<cmd>TroubleToggle quickfix<cr>",
      desc = "Quickfix",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sC",
      "<cmd>Telescope commands<cr>",
      desc = "Commands",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sM",
      "<cmd>Telescope man_pages<cr>",
      desc = "Man Pages",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sR",
      "<cmd>Telescope registers<cr>",
      desc = "Registers",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Checkout branch",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sc",
      "<cmd>Telescope colorscheme<cr>",
      desc = "Colorscheme",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Find Help",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Keymaps",
      nowait = true,
      remap = false,
    },
    {
      "<leader>sr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Open Recent File",
      nowait = true,
      remap = false,
    },
    {
      "<leader>u",
      "<cmd>set noexpandtab<cr><cmd>retab!<cr>",
      desc = "Spaces to Tabs",
      nowait = true,
      remap = false,
    },
    {
      "<leader>w",
      "<cmd>w!<CR>",
      desc = "Save",
      nowait = true,
      remap = false,
    },
  }
)

-- Groups
local groups = {
  {
    "<leader>D",
    group = "Diagnostics",
    nowait = true,
    remap = false,
  },
  {
    "<leader>T",
    group = "Terminal applications",
    nowait = true,
    remap = false,
  },
  {
    "<leader>a",
    group = "Tests",
    nowait = true,
    remap = false,
  },
  {
    "<leader>R",
    group = "Requests",
    nowait = true,
    remap = false,
  },
  {
    "<leader>g",
    group = "Git",
    nowait = true,
    remap = false,
  },
  {
    "<leader>m",
    group = "Plant UML",
    nowait = true,
    remap = false,
  },
  {
    "<leader>o",
    group = "DAP",
    nowait = true,
    remap = false,
  },
  {
    "<leader>p",
    group = "Python",
    nowait = true,
    remap = false,
  },
  {
    "<leader>r",
    group = "Diagnostics",
    nowait = true,
    remap = false,
  },
  {
    "<leader>s",
    group = "Search",
    nowait = true,
    remap = false,
  },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  tag = "v3.17.0",
  opts = {
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
  },
  keys = keys,
  config = function(_, opts)
    local which_key = require("which-key")
    which_key.setup(opts)
    which_key.add(groups)
  end,
}
