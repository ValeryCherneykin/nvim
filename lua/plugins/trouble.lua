-- Diagnostics / references list

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
		{ "<leader>tT", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
		{
			"<leader>tl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "LSP definitions",
		},
		{
			"[t",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
			desc = "Previous trouble",
		},
		{
			"]t",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Next trouble",
		},
	},
	opts = {
		auto_close = true,
		use_diagnostic_signs = true,
		icons = {
			indent = {
				top = "│ ",
				middle = "├╴",
				last = "└╴",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				Array = "A ",
				Boolean = "B ",
				Class = "C ",
				Constant = "K ",
				Constructor = "C ",
				Enum = "E ",
				Field = "F ",
				File = "F ",
				Function = "f ",
				Interface = "I ",
				Key = "K ",
				Method = "m ",
				Module = "M ",
				Namespace = "N ",
				Number = "N ",
				Object = "O ",
				Operator = "O ",
				Package = "P ",
				Property = "P ",
				String = "S ",
				Struct = "S ",
				TypeParameter = "T ",
				Variable = "V ",
			},
		},
	},
}
