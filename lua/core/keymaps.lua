local kopts = {noremap = true, silent = true}

local function mapkey(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, kopts)
end

local function mapcmd(key, cmd)
    vim.api.nvim_set_keymap('n', key, ':'..cmd..'<cr>', kopts)
end

mapkey('n', '<leader>ce', ':e<space>')
mapcmd('<leader>cw', 'w')
mapcmd('<leader>cW', 'wa')
mapcmd('<leader>cE', 'e!')
mapcmd('<leader>cq', 'q')
mapcmd('<leader>cQ', 'q!')
mapcmd('<leader>cx', 'x')

-- 健康检查
mapcmd("<leader>ch","checkhealth")
-- search
mapkey('n', '<leader>se', '/\\<lt>\\><left><left>')

-- window
mapkey('n', '<leader>wh', '<c-w>h')
mapkey('n', '<leader>wj', '<c-w>j')
mapkey('n', '<leader>wk', '<c-w>k')
mapkey('n', '<leader>wl', '<c-w>l')
mapkey('n', '<leader>w1', '<c-w>o')
mapkey("n", "<leader>wv", "<c-w>v") -- 水平新增窗口
mapkey("n", "<leader>ws", "<c-w>s") -- 垂直新增窗口
mapcmd('<leader>wx', 'x')
mapcmd('<leader>w2', 'sp')
mapcmd('<leader>w3', 'vs')
-- window resize
mapkey('n', '<M-9>', '<c-w><')
mapkey('n', '<M-0>', '<c-w>>')
mapkey('n', '<M-->', '<c-w>-')
mapkey('n', '<M-=>', '<c-w>+')
mapkey('n', '<M-r>', 'resize<space>')
mapkey('n', '<M-t>', 'vertical resize<space>')
--单行或多行移动
mapkey("v", "J", ":m '>+1<CR>gv=gv")
mapkey("v", "K", ":m '<-2<CR>gv=gv")
