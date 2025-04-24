local M = {}

function M.select_template()
  -- Get all files (non-recursively) under the "templates" folder.
  local folder = "templates"
  local files = vim.fn.globpath(folder, "*", false, true)
  if #files == 0 then
    vim.notify("No template files found in " .. folder, vim.log.levels.WARN)
    return
  end

  -- Show a selectable popup list
  vim.ui.select(files, {
    prompt = "Select a template file:",
    format_item = function(item)
      return vim.fn.fnamemodify(item, ":t")  -- show only the filename in the list
    end,
  },
  function(choice)
    if choice then
      print("Selected file: " .. choice)
    end
  end)
end

return M
