-- Keymaps

vim.g.mapleader = " "

-- Oil (file explorer)
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selection without overwriting the register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Better escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix / location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Go: quick error handling snippet
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Go: run current file
vim.keymap.set("n", "<leader>rr", "<cmd>!go run %<CR>")

-- Reload config
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("source $MYVIMRC")
	print("Config reloaded!")
end)

-- LSP restart
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Completion toggle (read by lsp.lua)
vim.g.cmp_enabled = false -- off by default, manual trigger only
vim.keymap.set("n", "<leader>ls", function()
	vim.g.cmp_enabled = not vim.g.cmp_enabled
	if vim.g.cmp_enabled then
		print("Completion: ON")
	else
		print("Completion: OFF")
	end
end, { desc = "Toggle completion" })
