local M = {}

local storage = require("ai.chat.shared.storage")

---Load sessions from disk
function M.load_sessions()
	local sessions_file = storage.get_sessions_file()
	print("Loading sessions from: " .. sessions_file)
	
	local file = io.open(sessions_file, "r")
	if file then
		local content = file:read("*all")
		file:close()
		print("File content: " .. (content or "empty"))
		
		if content and content ~= "" then
			local ok, data = pcall(vim.json.decode, content)
			if ok and data then
				print("Loaded sessions: " .. vim.inspect(data))
				storage.set_sessions(data.sessions or {})
				storage.set_current_session_id(data.current_session)
			else
				print("Failed to decode JSON: " .. (data or "unknown error"))
			end
		else
			print("File is empty, starting with no sessions")
		end
	else
		print("File does not exist, starting with no sessions")
	end
end

---Save sessions to disk
function M.save_sessions()
	local data = {
		sessions = storage.get_sessions(),
		current_session = storage.get_current_session_id(),
	}
	local content = vim.json.encode(data)
	local sessions_file = storage.get_sessions_file()
	
	-- Debug: print the file path and content
	print("Saving sessions to: " .. sessions_file)
	print("Sessions data: " .. vim.inspect(data))
	
	local file = io.open(sessions_file, "w")
	if file then
		file:write(content)
		file:close()
		print("Sessions saved successfully")
	else
		print("Failed to open file for writing: " .. sessions_file)
	end
end

return M