return {
  -- Плагин ZenMode
  "folke/zen-mode.nvim",
  config = function()
    -- Настройка для активации ZenMode с шириной 90 и отображением номеров строк
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").setup {
        window = {
          width = 90,
          options = {},
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
      ColorMyPencils()  -- Вызов функции для установки цвета
    end)

    -- Настройка для активации ZenMode с шириной 80 и без номеров строк
    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").setup {
        window = {
          width = 80,
          options = {},
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      vim.opt.colorcolumn = "0"
      ColorMyPencils()  -- Вызов функции для установки цвета
    end)
  end
}
