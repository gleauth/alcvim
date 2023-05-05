-- 功能加强和优化
return {
    -- 完善旧的quickfix窗口
    {
        "kevinhwang91/nvim-bqf",
        lazy = true,
        ft = "qf",
        opts = {
            auto_resize_height = true,
            preview = {
                win_height = 12,
                win_vheight = 12,
                delay_syntax = 80,
                border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'},
                show_title = false,
                should_preview_cb = function(bufnr, qwinid)
                    local ret = true
                    local bufname = vim.api.nvim_buf_get_name(bufnr)
                    local fsize = vim.fn.getfsize(bufname)
                    if fsize > 100 * 1024 then
                        ret = false
                    elseif bufname:match('^fugitive://') then
                        ret = false
                    end
                    return ret
                end
            },
            func_map = {
                drop = 'o',
                openc = 'O',
                split = '<M-I>',
                tabdrop = '<M-T>',
                tabc = '',
                ptogglemode = 'z,',
            },
            filter = {
                fzf = {
                    action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
                    extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
                }
            }
        }
    },
    -- 代码折叠
    {
        "kevinhwang91/nvim-ufo",
        lazy = true,
        init = function ()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        config = function ()
            -- 自定义折叠文本
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, {chunkText, hlGroup})
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, {suffix, 'MoreMsg'})
                return newVirtText
            end
            require('ufo').setup({
                provider_selector = function (bufnr,filetype,buftype)
                    return {"treesitter","indent"}
                end,
                fold_virt_text_handler = handler
            })
            vim.keymap.set('n', '<leader>zo', require('ufo').openAllFolds,{desc = "Open All Folds"})
            vim.keymap.set('n', '<leader>zc', require('ufo').closeAllFolds,{desc = "Close All Folds"})
            vim.keymap.set('n', '<leader>zk', require('ufo').openFoldsExceptKinds,{desc = "Open Folds ExceptKinds"})
            vim.keymap.set('n', '<leader>zw', require('ufo').closeFoldsWith,{desc = "Close Folds With"})
        end
    },
    -- 改进了Yank和Put功能
    {
        "gbprod/yanky.nvim",
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        keys = {
            {"<leader>yr","<cmd>YankyRingHistory<CR>",desc = "Show Yank History"},
            {"<leader>yc","<cmd>YankyClearHistory<CR>",desc = "Clear Yank History"}
        },
        dependencies = {"telescope.nvim"},
        opts = {
            ring = {
                history_length = 200,
                storage = "sqlite"
            },
            preserve_cursor_position = {
                enable = true
            }
        }
    },
    -- 增强了w,e,b,ge的功能
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            {"w",mode = {"n","o","x"},desc = "Spider-w"},
            {"e",mode = {"n","o","x"},desc = "Spider-e"},
            {"b",mode = {"n","o","x"},desc = "Spider-b"},
            {"ge",mode = {"n","o","x"},desc = "Spider-ge"}
        },
        config = function ()
            vim.keymap.set({"n","o","x"},"w", function() require("spider").motion("w") end)
            vim.keymap.set({"n","o","x"},"e", function() require("spider").motion("e") end)
            vim.keymap.set({"n","o","x"},"b", function() require("spider").motion("b") end)
            vim.keymap.set({"n","o","x"},"ge", function() require("spider").motion("ge") end)
        end
    },
    -- 预览寄存器内容
    {
        "tversteeg/registers.nvim",
        name = "registers",
        lazy = true,
        cmd = "Registers",
        keys = {
            {"\"",mode = {"n","v"},desc = "Peek Regeisters Content"},
            {"<C-R>",mode = "i"}
        },
        opts = {}
    },
    -- 弹出按键绑定和输入命令窗口
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup({
                window = {
                    border = "shadow"
                }
            })
        end
    },
    -- 测量启动时间
    {
        "dstein64/vim-startuptime",
        lazy = true,
        cmd = "StartupTime",
        keys = {
            {"<leader>st","<cmd>StartupTime<CR>",desc = "Show Neovim Start Time"}
        }
    },
    -- 更好的模式切换
    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = "InsertEnter",
        opts = {
            mapping = {"jk", "jj"},
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        }
    },
    -- 平滑滚动
    {
        "karb94/neoscroll.nvim",
        event = "VimEnter",
        opts = {}
    },
    -- 输入命令查看缓冲区
    {
        "nacro90/numb.nvim",
        lazy = true,
        event = "CmdlineEnter",
        opts = {
            number_only = true
        },
        keys = {
            {"<leader>ne","<cmd>lua require('numb').setup()<CR>",desc = "Start Command Show Current Buffer"},
            {"<leader>nd","<cmd>lua require('numb').disable()<CR>",desc = "Disable Command Show Current Buffer"}
        }
    },
    -- 改进位置列表导航
    {
        "cbochs/portal.nvim",
        lazy = true,
        cmd = "Portal",
        keys = {
            {"<leader>pb","<cmd>Portal jumplist backward<CR>",desc = "Jumplist Backward"},
            {"<leader>pf","<cmd>Portal jumplist forward<CR>",desc = "Jumplist Forward"}
        },
        dependencies = {
            {"grapple.nvim"},
            {"harpoon"}
        }
    },
    -- 改进缓冲区删除
    {
        "ojroques/nvim-bufdel",
        lazy = true,
        keys = {
            {"<leader>bd","<cmd>BufDel<CR>",desc = "Close Current Buffer"},
            {"<leader>bi","<cmd>BufDel!<CR>",desc = "Close Current Buffer And Ignore Modify"},
            {"<leader>ba","<cmd>BufDelAll<CR>",desc = "Close All Buffers"},
            {"<leader>bo","<cmd>BufDelOthers<CR>",desc = "Close Others Buffer"},
            {"<leader>bs",":BufDel ",desc = "Close Specify Buffer(Name Number Use '')"}
        },
        opts = {
            quit = false
        }
    },
    -- 改进了正则表达式
    {
        "chrisgrieser/nvim-alt-substitute",
        lazy = true,
        keys = {
            {"<leader>sg",mode = {"n","x"},desc = "󱗘 :AltSubstitute"},
            {"<leader>sa",mode = {"n","x"},desc = "󱗘 :AltSubstitute word under cursor",expr = true}
        },
        event = "CmdlineEnter",
        config = function ()
            vim.keymap.set({"n","x"},"<leader>sg",[[:S ///g<Left><Left><Left>]])
            vim.keymap.set({"n","x"},"<leader>sa",function()
                return ":S /" .. vim.fn.expand("<cword>") .. "//g<Left><Left>"
            end)
        end
    },
    -- 右侧小地图
    {
        "gorbit99/codewindow.nvim",
        lazy = true,
        keys = {
            {"<leader>mm",mode = {"n"},desc = "Toggle minimap"}
        },
        config = function ()
            require("codewindow").setup({
                window_border = "rounded",
            })
            require("codewindow").apply_default_keybinds()
        end
    }
}
