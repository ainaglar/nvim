return {
    'christoomey/vim-tmux-navigator',-- 用ctl-hjkl来定位窗口
    config = function()
        return {
            cmd = {
                "TmuxNavigateLeft",
                "TmuxNavigateDown",
                "TmuxNavigateUp",
                "TmuxNavigateRight",
                "TmuxNavigatePrevious",
            },
            keys = {
                { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
                { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
                { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
                { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
                { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
            },
        }
    end,
}