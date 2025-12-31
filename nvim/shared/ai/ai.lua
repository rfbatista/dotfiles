local M = {}

local terminal = require("ai.terminal")
local tab_manager = require("ai.tab_manager")
-- local vim_notify = require("notify")
local commands = require("ai.commands")
local send_selection = require("ai.commands.send_selection")
-- vim.notify = vim_notify

function M.toggle()
	return tab_manager.toggle()
end

function M.send_file()
	local file_path = vim.api.nvim_buf_get_name(0)
	terminal.send(commands.add.build(file_path))
end

function M.send_selection()
	send_selection()
end

function M.list_tabs()
	local active_tabs = tab_manager.get_active_tabs()

	if #active_tabs == 0 then
		vim.notify("No active tabs found", vim.log.levels.INFO)
		return
	end

	-- Prepare items for selection
	local items = {}
	for _, tab_name in ipairs(active_tabs) do
		table.insert(items, tab_name)
	end

	-- Use vim.ui.select for tab selection
	vim.ui.select(items, {
		prompt = "Select Tab:",
		format_item = function(item)
			local current_tab = tab_manager.get_current_tab()
			local prefix = (item == current_tab) and "● " or "  "
			return prefix .. item
		end,
	}, function(selected)
		if selected then
			tab_manager.switch_to_tab(selected)
		end
	end)
end

function M.create_or_select_tab()
	local all_tabs = tab_manager.get_all_tabs()
	local current_tab = tab_manager.get_current_tab()

	-- Sort tabs: active first, then inactive, both alphabetically
	table.sort(all_tabs, function(a, b)
		if a.active ~= b.active then
			return a.active -- active tabs first
		end
		return a.name < b.name -- then alphabetically
	end)

	-- Prepare items for selection
	local items = {}

	-- Add all existing tabs (active and inactive)
	for _, tab in ipairs(all_tabs) do
		table.insert(items, {
			value = tab.name,
			text = tab.name,
			active = tab.active,
		})
	end

	-- Add option to create new tab
	table.insert(items, {
		value = "__create_new__",
		text = "➕ Create New Tab",
		active = false,
	})

	-- Use vim.ui.select for tab selection
	vim.ui.select(items, {
		prompt = "Create or Select Tab:",
		format_item = function(item)
			local prefix = ""
			if item.value == "__create_new__" then
				return item.text
			end

			if item.value == current_tab then
				prefix = "● "
			elseif item.active then
				prefix = "▶ "
			else
				prefix = "○ "
			end

			return prefix .. item.text
		end,
	}, function(selected)
		if not selected then
			return
		end

		if selected.value == "__create_new__" then
			-- Prompt for new tab name
			vim.ui.input({
				prompt = "Tab name: ",
				default = "",
			}, function(name)
				if name and name ~= "" then
					vim.ui.input({
						prompt = "Command (empty for shell): ",
						default = vim.o.shell,
					}, function(cmd)
						tab_manager.switch_to_tab(name, cmd or vim.o.shell)
					end)
				end
			end)
		else
			-- Switch to selected tab (will restore if inactive)
			tab_manager.switch_to_tab(selected.value)
		end
	end)
end

vim.keymap.set({ "n", "t" }, "<A-o>", function()
	return tab_manager.toggle()
end, { noremap = true, silent = true })

vim.keymap.set("v", "<A-s>", function()
	M.send_selection()
end, { noremap = true, silent = true })

return M
