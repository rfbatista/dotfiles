local vim_notify = require("notify")

function _FORMAT_CODE()
  vim_notify("Formatando codigo...", "info")
  vim.lsp.buf.format()
  vim_notify("Codigo formatado", "info")
end

local mappings = {
  a = require("user.tests.main").keymap,
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  r = require("user.interface.trouble").keymap,
  j = require("user.languages.configs.jsonls").keymap,
  m = require("user.languages.configs.plantuml").keymap,
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["q"] = { "<cmd>q!<cr>", "Quit" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["k"] = { "<cmd>%bd|e#<CR>", "close all buffers" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["u"] = { "<cmd>set noexpandtab<cr><cmd>retab!<cr>", "Spaces to Tabs" },
  ["i"] = { "<cmd>set expandtab<cr><cmd>retab!<cr>", "Tabs to spaces" },

  n = {
    name = "Node",
    a = { "<cmd>2TermExec cmd='node %'<cr>", "Run current file" },
    b = { "<cmd>2TermExec cmd='npx ts-node-dev %'<cr>", "Run current file with typescript" },
  },

  g = {
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    b = { "<cmd>TSToolsOrganizeImports<CR>", "Organize imports" },
    c = { "<cmd>TSToolsRenameFile<CR>", "Typescript Rename File" },
    d = { "<cmd>TSToolsAddMissingImports<CR>", "Import all" },
    e = { "<cmd>TSToolsFixAll<CR>", "Fix all" },
    m = { "<cmd>TSToolsRemoveUnusedImports<CR>", "Remover imports nao utilizados" },
    -- e = { "<cmd>Prettier<CR>", "Prettier" },
    -- f = { "<cmd>PrettierCliPath<CR>", "Prettier beeing used" },
    f = { "<cmd>lua _FORMAT_CODE()<cr>", "Format" },
    g = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to definition" },
    h = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },

  p = {
    name = "Python",
    a = { "<cmd>2TermExec cmd='pipenv run python %'<cr>", "Run current file" },
  },

  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  t = {
    name = "Terminal",
    b = { "<cmd>ToggleTerm direction=tab<cr>", "Tab" },
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazy Docker" },
    e = { "<cmd>lua _START_NGROK()<cr>", "Start Ngrok" },
    f = { "<cmd>lua _OPEN_NGROK()<cr>", "Open Ngrok" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    l = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy Git" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    -- f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

return mappings
