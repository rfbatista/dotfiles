-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "",
		staged = "S",
		unmerged = "",
		renamed = "➜",
		deleted = "",
		untracked = "U",
		ignored = "◌",
	},
	folder = {
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
	},
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	disable_netrw = true,
	auto_reload_on_write = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = { "^.git$", "node_modules" },
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
	view = {
		width = 60,
		hide_root_folder = false,
		side = "right",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
				{ key = "<C-n>", cb = tree_cb("create") },
			},
		},
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

---- HYDRA
local api = require("nvim-tree.api")
-- auto show hydra on nvimtree focus
local function change_root_to_global_cwd()
	local global_cwd = vim.fn.getcwd()
	-- local global_cwd = vim.fn.getcwd(-1, -1)
	api.tree.change_root(global_cwd)
end

local hint = [[
 _w_: cd CWD   _c_: Path yank           _/_: Filter
 _y_: Copy     _x_: Cut                 _p_: Paste
 _r_: Rename   _d_: Remove              _n_: New
 _h_: Hidden   _?_: Help
 ^
]]
-- ^ ^           _q_: exit

local nvim_tree_hydra = nil
local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAu", { clear = true })
local Hydra = require("hydra")
local function spawn_nvim_tree_hydra()
	nvim_tree_hydra = Hydra({
		name = "NvimTree",
		hint = hint,
		config = {
			color = "pink",
			invoke_on_body = true,
			buffer = 0, -- only for active buffer
			hint = {
				position = "bottom",
				border = "rounded",
			},
		},
		mode = "n",
		body = "H",
		heads = {
			{ "w", change_root_to_global_cwd, { silent = true } },
			{ "c", api.fs.copy.absolute_path, { silent = true } },
			{ "/", api.live_filter.start, { silent = true } },
			{ "y", api.fs.copy.node, { silent = true } },
			{ "x", api.fs.cut, { exit = true, silent = true } },
			{ "p", api.fs.paste, { exit = true, silent = true } },
			{ "r", api.fs.rename, { silent = true } },
			{ "d", api.fs.remove, { silent = true } },
			{ "n", api.fs.create, { silent = true } },
			{ "h", api.tree.toggle_hidden_filter, { silent = true } },
			{ "?", api.tree.toggle_help, { silent = true } },
			-- { "q", nil, { exit = true, nowait = true } },
		},
	})
	nvim_tree_hydra:activate()
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function(opts)
		if vim.bo[opts.buf].filetype == "NvimTree" then
			spawn_nvim_tree_hydra()
		else
			if nvim_tree_hydra then
				nvim_tree_hydra:exit()
			end
		end
	end,
	group = nt_au_group,
})
