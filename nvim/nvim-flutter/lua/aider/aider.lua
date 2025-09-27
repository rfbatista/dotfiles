local M = {}

local terminal = require("aider.terminal")
local vim_notify = require("notify")
local commands = require("aider.commands")
vim.notify = vim_notify

vim.keymap.set({ "n", "t" }, "<A-o>", function()
  M.toggle()
end, { noremap = true, silent = true })

function M.select_template()
  -- Get all files (non-recursively) under the "templates" folder.
  local folder = "_templates"
  local files = vim.fn.globpath(folder, "*.tpl", false, true)
  if #files == 0 then
    vim.notify("No template files found in " .. folder, vim.log.levels.WARN)
    return
  end
  -- Show a selectable popup list
  vim.ui.select(files, {
    prompt = "Select a template file:",
    format_item = function(item)
      return vim.fn.fnamemodify(item, ":t") -- show only the filename in the list
    end,
  }, function(choice)
    if choice then
      terminal.send(commands.add.value .. " " .. choice)
    end
  end)
end

function M.toggle()
  terminal.toggle()
end

function M.send_file()
  local file_path = vim.api.nvim_buf_get_name(0)
  terminal.send(commands.add.value .. " " .. file_path)
end

return M
