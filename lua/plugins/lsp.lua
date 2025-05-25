return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim",           cmd = { "Mason", "MasonInstall" } },
        { "williamboman/mason-lspconfig.nvim", cmd = { "Mason" } },
        { "stevearc/conform.nvim",             event = { "BufWritePre" } },
        { "j-hui/fidget.nvim",                 event = { "LspAttach" } },
        { "hrsh7th/nvim-cmp",                  event = "InsertEnter" },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                go = { "gofmt" },
                dockerfile = { "dockerfile_formatter" },
                html = { "prettier" },
                css = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "gopls", "lua_ls", "dockerls", "html", "cssls", "intelephense" },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({ capabilities = capabilities })
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup({
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                gofumpt = true,
                                analyses = { unusedparams = true, shadow = true },
                                staticcheck = true,
                            },
                        },
                    })
                end,
                ["dockerls"] = function()
                    require("lspconfig").dockerls.setup({ capabilities = capabilities })
                end,
                ["html"] = function()
                    require("lspconfig").html.setup({ capabilities = capabilities })
                end,
                ["cssls"] = function()
                    require("lspconfig").cssls.setup({
                        capabilities = capabilities,
                        settings = { css = { lint = { unknownAtRules = "ignore" } } },
                    })
                end,
                ["intelephense"] = function()
                    require("lspconfig").intelephense.setup({
                        capabilities = capabilities,
                        settings = { intelephense = { files = { maxSize = 5000000 } } },
                    })
                end,
            },
        })

        require("fidget").setup({})

        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = {
                { name = "nvim_lsp", max_item_count = 10 },
                { name = "luasnip",  max_item_count = 5 },
                { name = "buffer",   keyword_length = 4, max_item_count = 5 },
                { name = "path",     max_item_count = 5 },
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 2,
            },
            performance = {
                debounce = 60,
                throttle = 30,
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "cmdline" } },
        })

        vim.diagnostic.config({
            virtual_text = { prefix = "●", source = "if_many" },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = { focusable = false, style = "minimal", border = "rounded", source = "always" },
        })
    end,
}
