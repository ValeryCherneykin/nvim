local function ColorMyPencils(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
            ColorMyPencils()
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        enabled = false,
        config = function()
            require("rose-pine").setup({
                disable_background = true,
            })
        end,
    },
}
