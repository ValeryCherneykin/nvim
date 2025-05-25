return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            { "<leader>tt", desc = "Toggle diagnostics" },
            { "[t",         desc = "Next trouble item" },
            { "]t",         desc = "Previous trouble item" },
        },
        config = function()
            require("trouble").setup({
                icons = {
                    error = "E",
                    warning = "W",
                    hint = "H",
                    information = "I",
                },
                auto_close = true,
                use_diagnostic_signs = true,
            })

            -- Keymaps
            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle("diagnostics")
            end, { desc = "Toggle diagnostics" })

            vim.keymap.set("n", "[t", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end, { desc = "Next trouble item" })

            vim.keymap.set("n", "]t", function()
                require("trouble").prev({ skip_groups = true, jump = true })
            end, { desc = "Previous trouble item" })
        end,
    },
}
