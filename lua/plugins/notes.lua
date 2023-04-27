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
                ["core.concealer"] = {},
                ["core.dirman"] = {
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
            {"<leader>fm","<cmd>FeMaco<CR>",desc="Call new window edit code"}
        },
        opts = {}
    },
    -- 突出显示markdown代码块
    {
        "yaocccc/nvim-hl-mdcodeblock.lua",
        lazy = true,
        ft = "markdown",
        opts = {}
    },
    -- 处理文本
    {
        "renerocksai/telekasten.nvim",
        lazy = true,
        cmd = "Telekasten",
        keys = {
            {"<leader>tl",":Telekasten",desc = "Telekasten commands"}
        },
        dependencies = {"telescope.nvim"},
        opts = {
            home = vim.fn.expand("~/Notes/zettelkasten")
        }
    }
}
