return {
    -- 练习基本动作
    {
        "ThePrimeagen/vim-be-good",
        lazy = true,
        cmd = "VimBeGood",
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
    }
}
