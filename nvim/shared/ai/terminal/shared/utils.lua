local M = {}

local config = require("ai.config")

---Create command string from options
---@param opts nvim_aider.Config
---@return string
function M.create_cmd(opts)
	local cmd = { opts.aider_cmd }
	vim.list_extend(cmd, opts.args or {})

	if opts.theme then
		for key, value in pairs(opts.theme) do
			table.insert(cmd, "--" .. key:gsub("_", "-") .. "=" .. tostring(value))
		end
	end

	return table.concat(cmd, " ")
end

---Send text to terminal channel
---@param chan number Terminal channel
---@param text string Text to send
---@param multi_line boolean Whether to use bracketed paste
function M.send_to_channel(chan, text, multi_line)
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
end

---Check if terminal is valid
---@param term table Terminal object
---@return boolean
function M.is_terminal_valid(term)
	if not term then
		return false
	end

	if type(term.buf_valid) == "function" then
		return term:buf_valid()
	end

	local bufnr = term.bufnr or term.buf
	return type(bufnr) == "number" and vim.api.nvim_buf_is_valid(bufnr)
end

---Get terminal channel
---@param term table Terminal object
---@return number?
function M.get_terminal_channel(term)
	if M.is_terminal_valid(term) then
		if type(term.job_id) == "number" and term.job_id > 0 then
			return term.job_id
		end

		local bufnr = term.bufnr or term.buf
		if type(bufnr) == "number" and vim.api.nvim_buf_is_valid(bufnr) then
			local ok, job_id = pcall(vim.api.nvim_buf_get_var, bufnr, "terminal_job_id")
			if ok then
				return job_id
			end
		end
	end
	return nil
end

return M