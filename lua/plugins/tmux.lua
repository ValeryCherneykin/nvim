return {
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<C-h>",  desc = "Navigate left (tmux)" },
            { "<C-j>",  desc = "Navigate down (tmux)" },
            { "<C-k>",  desc = "Navigate up (tmux)" },
            { "<C-l>",  desc = "Navigate right (tmux)" },
            { "<C-\\>", desc = "Navigate previous (tmux)" },
        },
        event = "VeryLazy",
    },
}
