------ quick commands ------
vim.keymap.set("n","<leader>ce", "<cmd>enew<CR>",{desc = "New File"})
vim.keymap.set("n","<leader>cw", "<cmd>w<CR>",{desc = "Buffer Write File"})
vim.keymap.set("n",'<leader>cW', "<cmd>wa<CR>",{desc = "Write All File"})
vim.keymap.set("n",'<leader>cE', "<cmd>e!<CR>",{desc = "Revoke all file changes"})
vim.keymap.set("n",'<leader>cq', "<cmd>q<CR>",{desc = "Quit"})
vim.keymap.set("n",'<leader>cQ', "<cmd>q!<CR>",{desc = "Force Quit"})
vim.keymap.set("n",'<leader>cx', "<cmd>x<CR>",{desc = "Save And Quit"})
vim.keymap.set("n","<leader>ch", "<cmd>checkhealth<CR>",{desc = "Neovim Health Check"})

------ keybinds ------
-- window
vim.keymap.set('n', '<leader>wh', '<c-w>h',{desc = "Goto left window"})
vim.keymap.set('n', '<leader>wj', '<c-w>j',{desc = "Goto lower window"})
vim.keymap.set('n', '<leader>wk', '<c-w>k',{desc = "Goto upper window"})
vim.keymap.set('n', '<leader>wl', '<c-w>l',{desc = "Goto right window"})
vim.keymap.set("n", "<leader>wv", "<c-w>v",{desc = "Horizontal addition window"})
vim.keymap.set("n", "<leader>ws", "<c-w>s",{desc = "Vertical addition window"})
vim.keymap.set('n', '<M-9>', '<c-w><',{desc = "Reduce window width"})
vim.keymap.set('n', '<M-0>', '<c-w>>',{desc = "Increase window width"})
vim.keymap.set('n', '<M-->', '<c-w>-',{desc = "Reduce window height"})
vim.keymap.set('n', '<M-=>', '<c-w>+',{desc = "Increase window height"})
-- line move
vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
vim.keymap.set("v","K",":m '<-2<CR>gv=gv")
vim.keymap.set("n","j","v:count == 0 ? 'gj' : 'j'",{expr = true,silent = true})
vim.keymap.set("n","k","v:count == 0 ? 'gk' : 'k'",{expr = true,silent = true})
-- indent
vim.keymap.set("v","<","<gv")
vim.keymap.set("v",">",">gv")
-- search
vim.keymap.set('n', '<leader>se', '/\\<lt>\\><left><left>')
