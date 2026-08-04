-- Fuzzy finder

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				height = 0.85,
				width = 0.80,
				preview = {
					hidden = "hidden",
					default = "bat",
					border = "border",
					layout = "vertical",
					vertical = "down:50%",
				},
			},
			fzf_opts = {
				["--layout"] = "reverse",
				["--info"] = "inline",
			},
			keymap = {
				builtin = {
					["<C-u>"] = "preview_page_up",
					["<C-d>"] = "preview_page_down",
					["<C-p>"] = "toggle_preview",
				},
				fzf = {
					["ctrl-j"] = "down",
					["ctrl-k"] = "up",
				},
			},
			files = {
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
				cwd_prompt = true,
				path_shorten = false,
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
			},
		})
		vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "Find files" })
		vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "Git files" })
		vim.keymap.set("n", "<leader>ps", fzf.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>pb", fzf.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>vh", fzf.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<leader>pv", function()
			fzf.files({
				cwd = vim.fn.getcwd(),
				winopts = { preview = { hidden = "nohidden" } },
			})
		end, { desc = "Files with preview" })
		vim.keymap.set("n", "<leader>pa", function()
			fzf.files({
				fd_opts = "--color=never --type f --hidden --follow --no-ignore",
				winopts = { preview = { hidden = "nohidden" } },
			})
		end, { desc = "All files including hidden" })
	end,
}
