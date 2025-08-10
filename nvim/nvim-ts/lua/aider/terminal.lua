local M = {}

local config = require("aider.config")

---@param opts nvim_aider.Config
---@return string
local function create_cmd(opts)
  local cmd = { opts.aider_cmd }
  vim.list_extend(cmd, opts.args or {})

  if opts.theme then
    for key, value in pairs(opts.theme) do
      table.insert(cmd, "--" .. key:gsub("_", "-") .. "=" .. tostring(value))
    end
  end

  return table.concat(cmd, " ")
end

---Toggle terminal visibility
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
---@return snacks.win?
function M.toggle(opts)
  local snacks = require("snacks.terminal")

  opts = vim.tbl_deep_extend("force", config.options, opts or {})

  local cmd = create_cmd(opts)
  return snacks.toggle(cmd, opts)
end

---Send text to terminal
---@param text string Text to send
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
---@param multi_line? boolean Whether to send as multi-line text (default: true)
function M.send(text, opts, multi_line)
  multi_line = multi_line == nil and true or multi_line
  opts = vim.tbl_deep_extend("force", config.options, opts or {})

  local cmd = create_cmd(opts)
  local term = require("snacks.terminal").get(cmd, opts)
  if not term then
    vim.notify("Please open an Aider terminal first.", vim.log.levels.INFO)
    return
  end

  if term and term:buf_valid() then
    local chan = vim.api.nvim_buf_get_var(term.buf, "terminal_job_id")
    if chan then
      if multi_line then
        -- Use bracketed paste sequences
        local bracket_start = "\27[200~"
        local bracket_end = "\27[201~\r"
        local bracketed_text = bracket_start .. text .. bracket_end
        vim.api.nvim_chan_send(chan, bracketed_text)
      else
        text = text:gsub("\n", " ") .. "\n"
        vim.api.nvim_chan_send(chan, text)
      end
    else
      vim.notify("No Aider terminal job found!", vim.log.levels.ERROR)
    end
  else
    vim.notify("Please open an Aider terminal first.", vim.log.levels.INFO)
  end
end

---Send a command to the terminal
---@param command string Aider command (e.g. "/add")
---@param text? string Text to send after the command
---@param opts? nvim_aider.Config Optional config that will override the base config for this call only
function M.command(command, text, opts)
  text = text or ""

  opts = vim.tbl_deep_extend("force", config.options, opts or {})
  -- NOTE: For Aider commands that shouldn't get a newline (e.g. `/add file`)
  M.send(command .. " " .. text, opts, false)
end

---Send text to aider terminal
---@param text? string Optional text to send (nil for visual selection/mode-based handling)
---@param opts? table Optional configuration override
function M.send_to_terminal(text, opts)
  local mode = vim.fn.mode()
  local selected_text = text or ""
  -- Visual mode handling
  if vim.tbl_contains({ "v", "V", "" }, mode) then
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
    selected_text = table.concat(lines, "\n")

    vim.ui.input({ prompt = "Add a prompt to your selection (empty to skip):" }, function(input)
      if input ~= nil then
        if input ~= "" then
          selected_text = selected_text .. "\n> " .. input
        end
        M.send(selected_text, opts or {}, true)
      end
    end)
  else
    -- Normal mode handling
    if selected_text == "" then
      vim.ui.input({ prompt = "Send to Aider: " }, function(input)
        if input then
          M.send(input, opts or {})
        end
      end)
    else
      M.send(selected_text, opts or {}, true)
    end
  end
end

return M
