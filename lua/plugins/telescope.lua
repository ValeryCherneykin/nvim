return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-l>"] = "select_default",
                        ["<C-u>"] = "preview_scrolling_up",
                        ["<C-d>"] = "preview_scrolling_down",
                    },
                },
                cache_picker = {
                    num_pickers = 5,
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
        vim.keymap.set("n", "<leader>pws", function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end, { desc = "Grep word under cursor" })
        vim.keymap.set("n", "<leader>pWs", function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end, { desc = "Grep WORD under cursor" })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Grep custom string" })
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
    end,
}
