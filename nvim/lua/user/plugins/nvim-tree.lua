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

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
		{ "anuvyklack/hydra.nvim" },
	},
	config = function()
		local function tree_on_attach(bufnr)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			local api = require("nvim-tree.api")

			local function edit_or_open()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil then
					-- expand or collapse folder
					api.node.open.edit()
				else
					-- open file
					api.node.open.edit()
					-- Close the tree if file was opened
					api.tree.close()
				end
			end

			-- open as vsplit on current node
			local function vsplit_preview()
				local node = api.tree.get_node_under_cursor()

				if node.nodes ~= nil then
					-- expand or collapse folder
					api.node.open.edit()
				else
					-- open file as vsplit
					api.node.open.vertical()
				end

				-- Finally refocus on tree if it was lost
				api.tree.focus()
			end
			-- on_attach
			vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
			vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
			vim.keymap.set("n", "h", api.tree.close, opts("Close"))
			vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
		end
		require("nvim-tree").setup({
			disable_netrw = true,
			auto_reload_on_write = true,
			hijack_netrw = true,
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
				side = "right",
				number = false,
				relativenumber = false,
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
			on_attach = tree_on_attach,
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
	end,
}
