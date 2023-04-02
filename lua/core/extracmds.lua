local kopts = {noremap = true, silent = true}

local function mapcmd(key, cmd)
    vim.api.nvim_set_keymap('n', key, ':'..cmd..'<cr>', kopts)
end

-- 快速打开Lazy界面
mapcmd("<leader>la","Lazy")
-- 查看lazygit日志
vim.keymap.set("n","<leader>ll",function()
    require("lazy.util").float_term({ "lazygit","log" })
end,{desc = "Show Lazygit Log"})

require("core.autocmds")
