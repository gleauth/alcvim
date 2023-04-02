-- 注释类插件
return {
     -- 快速注释
     {
        "numToStr/Comment.nvim",
        lazy = true,
        keys = {
            {"gcc",mode = {"n"},desc = "line comment"},
            {"gCC",mode = {"n"},desc = "line block comment"},
            {"gcO",mode = {"n"},desc = "prev line comment"},
            {"gco",mode = {"n"},desc = "next line comment"},
            {"gcA",mode = {"n"},desc = "tail line comment"},
            {"gc",mode = {"v"},desc = "visual line comment"},
            {"gb",mode = {"v"},desc = "visual block comment"}
        },
        config = function ()
            local opts = {
                -- Normal模式下注释命令
                toggler = {
                    line = "gcc",
                    block = "gCC",
                },
                -- Visual模式下注释命令
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
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
            require("Comment").setup(opts)
        end
    },
    -- TODO注释样式
    {
        "folke/todo-comments.nvim",
        lazy = true,
        cmd = {"TodoTrouble","TodoTelescope","TodoQuickFix","TodoLocList"},
        keys={
            -- 查找TODO标签
            {"<leader>tdt","<cmd>TodoTelescope theme=ivy<CR>",desc = "Find TODO Tag"},
            -- 筛选关键词
            {"<leader>tdg",":TodoTelescope keywords=",desc = "screen keyswords"},
            -- 指定搜索目录
            {"<leader>tdd",":TodoTrouble cwd=",desc = "Search Specify Directory"},
            -- 使用快速修复列表显示项目中的所有代办事项
            {"<leader>tdq","<cmd>TodoQuickFix<CR>",desc = "Use QuickFix Show Todo Projects"},
            -- 使用位置列表显示项目中的所有代办事项
            {"<leader>tdl","<cmd>TodoLocList<CR>",desc = "Use Localist Show Todo Projects"},
            -- TODO标签跳转
            {"[t",mode = "n",desc = "Todo Jump Prev"},
            {"]t",mode = "n",desc = "Todo Jump Next"}
        },
        ft = {"c","cpp","lua","python","java","javascript","typescript","yaml","vim","toml",
            "sh","rust","json","css","html","xml","markdown","cmake"},
        dependencies = {"plenary.nvim"},
        config = function ()
            require("todo-comments").setup({
                keywords = {
                    -- alt:别名
                    FIX =  {icon = " ", color = "#DC2626", alt = {"FIXME", "BUG", "FIXIT", "ISSUE", "!"}},
                    TODO = {icon = " ", color = "#10B981"},
                    HACK = {icon = " ", color = "#7C3AED"},
                    WARN = {icon = " ", color = "#FBBF24", alt = {"WARNING", "XXX"}},
                    PERF = {icon = " ", color = "#FC9868", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}},
                    NOTE = {icon = " ", color = "#2563EB", alt = {"INFO"}},
                    TEST = {icon = "⏲ ", color = "#FF00FF", alt = { "TESTING", "PASSED", "FAILED" }}
                }
            })
            vim.keymap.set("n","[t",function() require("todo-comments").jump_prev() end)
            vim.keymap.set("n","]t",function() require("todo-comments").jump_next() end)
        end
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
