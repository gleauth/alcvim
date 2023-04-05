-- 快速打开Lazy界面
vim.keymap.set({"n","v"},"<leader>la","<cmd>Lazy<CR>",{desc = "Open Lazy Menu"})
-- 查看lazygit日志
vim.keymap.set("n","<leader>ll",function()
    require("lazy.util").float_term({ "lazygit","log" })
end,{desc = "Show Lazygit Log"})

require("core.autocmds")
