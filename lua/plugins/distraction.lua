return {
    -- 练习基本动作
    {
        "ThePrimeagen/vim-be-good",
        lazy = true,
        keys = {
            {"<leader>bg","<cmd>VimBeGood<CR>",desc = "Start Vim Be Good"}
        }
    },
    -- 数独
    {
        "jim-fx/sudoku.nvim",
        lazy = true,
        cmd = "Sudoku",
        keys = {
            {"<leader>dk","<cmd>Sudoku<CR>",desc="Start sudoku game"}
        },
        opts = {
            mapping = {
                {key = "C",action = "clear_cell"}
            }
        }
    },
    -- 类似于hacker
    {
        "letieu/hacker.nvim",
        lazy = true,
        keys = {
            {"<leader>hk","<cmd>Hack<CR>",desc = "Start Hack Game"},
            {"<leader>hf","<cmd>HackFollow<CR>",desc = "Use Current Interface Start Hack Game"}
        },
        opts = {}
    },
    -- 执行美观的元胞自动机动画
    {
        "Eandrju/cellular-automaton.nvim",
        lazy = true,
        keys = {
            {"<leader>al","<cmd>CellularAutomaton game_of_life<CR>",desc = "Automation life for Cellular"},
            {"<leader>ar","<cmd>CellularAutomaton make_it_rain<CR>",desc = "Automation rain for Cellular"}
        }
    }
}
