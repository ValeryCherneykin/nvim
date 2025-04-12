return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "gofmt" },
        dockerfile = { "dockerfile_formatter" },
        html = { "prettier" },
        css = { "prettier" },
      }
    })

    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "gopls",
        "lua_ls",
        "dockerls", -- исправлено
        "html",
        "cssls",
        "intelephense",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["gopls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                gofumpt = true,
                analyses = {
                  unusedparams = true,
                  shadow = true,
                },
                staticcheck = true,
              },
            },
          })
        end,

        ["dockerls"] = function() -- исправлено
          local lspconfig = require("lspconfig")
          lspconfig.dockerls.setup({
            capabilities = capabilities,
          })
        end,
        ["html"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.html.setup({
            capabilities = capabilities,
            settings = {
              html = {
                suggest = {
                  html5 = true,
                  css = true,
                },
              },
            },
          })
        end,

        ["cssls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.cssls.setup({
            capabilities = capabilities,
            settings = {
              css = {
                lint = {
                  unknownAtRules = "ignore",
                },
              },
            },
          })
        end,
                ["intelephense"] = function()
  local lspconfig = require("lspconfig")
  lspconfig.intelephense.setup({
    capabilities = capabilities,
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000,
        },
      },
    },
  })
end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer', keyword_length = 4 },
      }),
      completion = {
        completeopt = 'menu,menuone,noinsert',
        keyword_length = 2,
        max_item_count = 10,
      },
      experimental = {
        native_menu = false,
      },
    })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
