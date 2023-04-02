-- 笔记和任务清单
return {
    -- 结构化笔记、项目和任务管理、时间跟踪、幻灯片、编写排版文档
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        lazy = true,
        ft = "norg",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Notes",
                            work = "~/Notes/work",
                            home = "~/Notes/home"
                        }
                    }
                }
            }
        }
    },
    -- markdown笔记管理
    {
        "jakewvincent/mkdnflow.nvim",
        lazy = true,
        ft = "markdown",
        opts = {
            mappings = {
                MkdnEnter = {{'i', 'n', 'v'}, '<CR>'}
            }
        }
    },
    -- markdown代码块管理
    {
        "AckslD/nvim-FeMaco.lua",
        lazy = true,
        keys = {
            {"<leader>fm","<cmd>FeMaco<CR>",desc="调用窗口编辑代码块"}
        },
        opts = {}
    },
    -- 任务工作流
    {
        "phaazon/mind.nvim",
        branch = "v2.2",
        lazy = true,
        keys = {
            {"<leader>mdc","<cmd>MindClose<CR>",desc = "Close Mind"},
            {"<leader>mdm","<cmd>MindOpenMain<CR>",desc = "Open Main Mind"},
            {"<leader>mdp","<cmd>MindOpenProject<CR>",desc = "Open Project Mind"},
            {"<leader>mdr","<cmd>MindReloadState<CR>",desc = "Reload State Mind"},
            {"<leader>mds","<cmd>MindOpenSmartProject<CR>",desc = "Open Smart Project Mind"}
        },
        opts = {}
    }
}
