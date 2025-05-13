return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" }, -- Ленивая загрузка при вызове команд
        keys = {
            { "<leader>tt", desc = "Toggle diagnostics" },
            { "[t",         desc = "Next trouble item" },
            { "]t",         desc = "Previous trouble item" },
        }, -- Загружаем при использовании keymaps
        config = function()
            require("trouble").setup({
                icons = {
                    error = "E",
                    warning = "W",
                    hint = "H",
                    information = "I",
                },
                auto_close = true,   -- Закрывать Trouble, если список пуст
                use_diagnostic_signs = true, -- Использовать знаки из LSP
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
