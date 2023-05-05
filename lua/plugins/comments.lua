-- 注释类插件
return {
    -- 快速注释
    {
        "numToStr/Comment.nvim",
        lazy = true,
        keys = {
            {"gcc",mode = {"n"},desc = "line comment"},
            {"gbc",mode = {"n"},desc = "block comment"},
            {"gcO",mode = {"n"},desc = "prev line comment"},
            {"gco",mode = {"n"},desc = "next line comment"},
            {"gcA",mode = {"n"},desc = "tail line comment"},
            {"gc",mode = {"v","n"},desc = "visual and normal line comment"},
            {"gb",mode = {"v","n"},desc = "visual and normal block comment"}
        },
        config = function()
            require("Comment").setup({
                -- Normal模式下注释命令
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                -- Visual和normal模式下注释命令
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                -- 额外的注释命令
                extra = {
                    -- 上行注释
                    above = "gcO",
                    -- 下行注释
                    below = "gco",
                    -- 尾部注释
                    eol = "gcA",
                },
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end
    },
    -- TODO注释样式
    {
        "folke/todo-comments.nvim",
        lazy = true,
        cmd = {"TodoTrouble","TodoTelescope","TodoQuickFix","TodoLocList"},
        keys={
            -- 查找TODO标签
            {"<leader>tdt","<cmd>TodoTelescope theme=ivy<CR>",desc = "Find ToDo Tag"},
            -- 筛选关键词
            {"<leader>tdg",":TodoTelescope keywords=",desc = "Screen keyswords"},
            -- 指定搜索目录
            {"<leader>tdd",":TodoTrouble cwd=",desc = "Search Specify Directory"},
            -- 使用快速修复列表显示项目中的所有代办事项
            {"<leader>tdq","<cmd>TodoQuickFix<CR>",desc = "Use QuickFix Show Todo Projects"},
            -- 使用位置列表显示项目中的所有代办事项
            {"<leader>tdl","<cmd>TodoLocList<CR>",desc = "Use Localist Show Todo Projects"},
        },
        ft = {"c","cpp","lua","python","java","javascript","typescript","yaml","vim","toml",
            "sh","json","css","html","xml","cmake"},
        dependencies = {"plenary.nvim"},
        init = function ()
            -- TODO标签跳转
            vim.keymap.set("n","[t",function() require("todo-comments").jump_prev() end,{desc = "Todo Jump Prev"})
            vim.keymap.set("n","]t",function() require("todo-comments").jump_next() end,{desc = "Todo Jump Next"})
        end,
        opts = {
            keywords = {
                FIX =  {icon = " ", color = "#DC2626", alt = {"FIXME", "BUG", "FIXIT", "ISSUE", "!"}},
                TODO = {icon = " ", color = "#10B981"},
                HACK = {icon = " ", color = "#7C3AED"},
                WARN = {icon = " ", color = "#FBBF24", alt = {"WARNING","XXX"}},
                PERF = {icon = " ", color = "#FC9868", alt = {"OPTIM","PERFORMANCE","OPTIMIZE"}},
                NOTE = {icon = " ", color = "#2563EB", alt = {"INFO"}},
                TEST = {icon = "⏲ ", color = "#FF00FF", alt = {"TESTING","PASSED","FAILED" }}
            }
        }
    },
    -- 注释生成器
    {
        "danymat/neogen",
        lazy = true,
        cmd = "Neogen",
        keys = {
            {"<leader>nog","<cmd>Neogen<CR>",desc="Generate Comment"},
            {"<leader>nof","<cmd>Neogen func<CR>",desc="Generate Function Comment"},
            {"<leader>noc","<cmd>Neogen class<CR>",desc="Generate Class Comment"},
            {"<leader>not","<cmd>Neogen type<CR>",desc="Generate Type Comment"},
            {"<leader>noi","<cmd>Neogen file<CR>",desc="Generate File Comment"}
        },
        opts = {
            snippet_engine = "luasnip",
        }
    }
}
