return {
    {
        "mhartington/formatter.nvim",
        event = "BufWritePost",
        config = function()
            require("formatter").setup({
                logging = false,
                filetype = {
                    go = {
                        function()
                            return {
                                exe = "gofmt",
                                args = { "-s", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                                stdin = true,
                            }
                        end,
                    },
                },
            })

            vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = "FormatAutogroup",
                pattern = "*.go",
                callback = function()
                    vim.cmd("silent! FormatWrite")
                end,
            })
        end,
    },
}
