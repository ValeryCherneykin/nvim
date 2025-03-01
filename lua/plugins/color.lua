return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm", -- night / storm / moon
      transparent = false,
      terminal_colors = true,
    })
    vim.cmd("colorscheme tokyonight")
  end
}
