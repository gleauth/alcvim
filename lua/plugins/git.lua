return {
    -- git集成
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        dependencies = {"plenary.nvim"},
        config = function()
            require("gitsigns").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
        keys = {
            {"<leader>gi","<cmd>Gitsigns<CR>",desc = "Open Gitsigns Select Args"},
            {"<leader>gt","<cmd>Gitsigns toggle_signs<CR>",desc = "Gitsigns Toggle Sings"},
            {"<leader>gh","<cmd>Gitsigns toggle_numhl<CR>",desc = "Gitsigns Toggle Numhl"},
            {"<leader>ge","<cmd>Gitsigns toggle_linehl<CR>",desc = "Gitsigns Toggle Linehl"},
            {"<leader>gw","<cmd>Gitsigns toggle_word_diff<CR>",desc = "Gitsigns Toggle Word Diff"},
            {"<leader>gc","<cmd>Gitsigns toggle_current_line_blame<CR>",desc = "Gitsigns Toggle Current Line Blame"},
            {"<leader>gf","<cmd>Gitsigns diffthis<CR>",desc = "Gitsigns This Diif"}
        }
    },
    -- neovim的magit
    {
        "TimUntersberger/neogit",
        lazy = true,
        cmd = "Neogit",
        keys = {
            {"<leader>gnt","<cmd>Neogit<CR>",desc = "Open Neoget Tab Page"},
            {"<leader>gnc","<cmd>Neogit commit<CR>",desc = "Open Neogit Commit Page"},
            {"<leader>gnd",":Neogit cwd=",desc = "Open Neoget Overrride CWD"},
            {"<leader>gnk",":Neogit kind=",desc = "Open Neogit Overrride Kind"}
        },
        dependencies = {
            {"diffview.nvim"},
            {"plenary.nvim"}
        },
        opts = {
            integrations = {
                diffview = true
            }
        }
    },
    -- 环浏览任何 git 版本的所有修改文件的差异
    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = {"DiffviewRefresh","DiffviewFocusFiles"},
        keys = {
            {"<leader>dvh","<cmd>DiffviewFileHistory<CR>",desc = "View All Files History Diff"},
            {"<leader>dvf","<cmd>DiffviewFileHistory %<CR>",desc = "View Current File History Diff"},
            {"<leader>dvt","<cmd>DiffviewToggleFiles<CR>",desc = "Toggle File Diff Panel"},
            {"<leader>dvl","<cmd>DiffviewLog<CR>",desc = "Show File Log"}
        },
        opts = {
            view = {
                default = {
                    winbar_info = true
                }
            }
        }
    }
}
