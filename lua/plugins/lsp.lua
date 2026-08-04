-- LSP configuration
-- No Mason: language servers come from system packages (pacman: gopls, lua-language-server)

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				completion = {
					autocomplete = false,
					completeopt = "menu,menuone,noinsert",
					keyword_length = 2,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						max_height = 10,
						max_width = 60,
						border = "rounded",
					},
					documentation = {
						max_height = 15,
						max_width = 60,
						border = "rounded",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-l>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.close()
						else
							cmp.complete()
						end
					end, { "i" }),
				}),
				sources = {
					{ name = "nvim_lsp", max_item_count = 10 },
					{ name = "luasnip", max_item_count = 5 },
					{ name = "buffer", keyword_length = 4, max_item_count = 5 },
					{ name = "path", max_item_count = 5 },
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

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				end,
			})

			vim.lsp.config("gopls", {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.work", "go.mod", ".git" },
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						analyses = { unusedparams = true, shadow = true },
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.enable("gopls")
			vim.lsp.enable("lua_ls")

			vim.diagnostic.config({
				virtual_text = { prefix = "●", source = "if_many" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
				},
			})

			-- Format + organize imports on save for Go files
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					vim.lsp.buf.format({ async = false })
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
					for _, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
							end
						end
					end
				end,
			})
		end,
	},
}
