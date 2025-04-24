local M = {}

local vim_notify = require("notify")

function _FORMAT_CODE()
  vim_notify("Formatando codigo...", "info")
  vim.lsp.buf.format()
  vim_notify("Codigo formatado", "info")
end

-- Utility function to call aider with the given query
function M.request(query)
  local cmd = { "aider", query }  -- adjust if aider needs more flags/arguments
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- For example, display aider output as a notification.
        vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.notify("Aider error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
  })
end

-- Setup the aide plugin by creating a user command
function M.setup()
  vim.api.nvim_create_user_command("AiderRequest", function(opts)
    if opts.args == "" then
      vim.notify("Please provide a query for aider", vim.log.levels.WARN)
      return
    end
    M.request(opts.args)
  end, {
    nargs = 1,  -- requires one argument (the query)
  })
end

return M
