-- 此文件作为其它插件公共依赖调用
return {
    -- 减少lua函数的编写
    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },
    -- 支持异步
    {
        "kevinhwang91/promise-async",
        lazy = true
    },
    -- 改进了默认vim.ui界面
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function ()
            vim.ui.select = function(...)
                require("lazy").load({plugins={"dressing.nvim"}})
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({plugins={"dressing.nvim"}})
                return vim.ui.input(...)
            end
        end,
        opts = {}
    },
    -- neovim的UI组件库
    {
        "MunifTanjim/nui.nvim",
        lazy = true
    },
    -- 图标支持插件
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {}
    },
    -- 避免重复回调
    {
        "tpope/vim-repeat",
        event = "VeryLazy"
    },
    -- 提供对sqlite的操作，用户保存会话，输入历史
    {
        "kkharji/sqlite.lua",
        lazy = true
    },
    -- 管理lsp,dap,diagnostics,formatting服务的安装
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = {"Mason","MasonInstall","MasonUninstall","MasonLog","MasonUpdate"},
        keys = {
            {"<leader>ms","<cmd>Mason<CR>",desc = "Open Mason Install Interface"},
            {"<leader>ml","<cmd>MasonLog<CR>",desc = "Open Mason Log"}
        },
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    }
}
