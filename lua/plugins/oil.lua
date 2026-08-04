-- File explorer as a buffer

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
			"size",
			"mtime",
		},
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		skip_confirm_for_simple_edits = false,
		preview_win = {
			update_on_cursor_moved = true,
		},
		view_options = {
			show_hidden = false,
			is_hidden_file = function(name, _)
				return vim.startswith(name, ".")
			end,
			is_always_hidden = function(name, _)
				return name == ".git"
			end,
		},
		float = {
			padding = 2,
			max_width = 80,
			max_height = 30,
			border = "rounded",
		},
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-s>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-r>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["g."] = "actions.toggle_hidden",
			["gs"] = "actions.change_sort",
			["q"] = "actions.close",
			["gp"] = "actions.copy_entry_path",
		},
		use_default_keymaps = false,
	},
}
