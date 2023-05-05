-- 一些有用的小玩意
return {
    -- 命令面板
    {
        "mrjones2014/legendary.nvim",
        lazy = true,
        keys = {
            {"<leader>ldy","<cmd>Legendary<CR>",desc="Show Legendary"},
            {"<leader>ldk","<cmd>Legendary keymaps<CR>",desc = "Search Keymaps"},
            {"<leader>ldc","<cmd>Legendary commands<CR>",desc="Search Commands"},
            {"<leader>ldf","<cmd>Legendary functions<CR>",desc="Search Functions"},
            {"<leader>lda","<cmd>Legendary autocmds<CR>",desc="Search Autocmds"}
        },
        dependencies = {"telescope.nvim"},
        opts = {
            which_key = {
                auto_register = true,
            }
        }
    },
    -- 颜色选择器
    {
        "uga-rosa/ccc.nvim",
        lazy = true,
        keys = {
            {"<leader>ccp","<cmd>CccPick<CR>",desc = "Check And Replace Cursor Local Color"},
            {"<leader>ccn","<cmd>CccConvert<CR>",desc = "Direct Change Color Form"},
            {"<leader>cct","<cmd>CccHighlighterToggle<CR>",desc = "Switch Buffer Color"},
            {"<leader>cce","<cmd>CccHighlighterEnable<CR>",desc = "Open Show Buffer Color"},
            {"<leader>ccd","<cmd>CccHighlighterDisable<CR>",desc = "Close Show Buffer Color"}
        },
        opts = {}
    },
    -- 页面切换器
    {
        "toppair/reach.nvim",
        lazy = true,
        keys = {
            {"<leader>rb","<cmd>ReachOpen buffers<CR>",desc="Switch Buffers Page"},
            {"<leader>rc","<cmd>ReachOpen colorschemes<CR>",desc="Switch Scheme Page"},
            {"<leader>rm","<cmd>ReachOpen marks<CR>",desc="Switch Mark Page"},
            {"<leader>rt","<cmd>ReachOpen tabpages<CR>",desc="Switch Tab Page"}
        },
        opts = {
            notifications = true
        }
    },
    -- 非活动代码变暗
    {
        "folke/twilight.nvim",
        lazy = true,
        keys = {
            {"<leader>twl","<cmd>Twilight<CR>",desc = "Inactive Code Shade"},
            {"<leader>twe","<cmd>TwilightEnable<CR>",desc = "Enable Inactive Code Shade"},
            {"<leader>twd","<cmd>TwilightDisable<CR>",desc = "Disable Inactive Code Shade"}
        },
        opts = {
            dimming = {
                inactive = true,
            },
            exclude = {"txt","markdown","log","help"},
        }
    },
    -- 禅模式
    {
        "folke/zen-mode.nvim",
        lazy = true,
        keys = {
            {"<leader>mz", "<cmd>ZenMode<CR>",desc = "Zen Mode"}
        },
        opts = {}
    },
    -- 图标选择器
    {
        "ziontee113/icon-picker.nvim",
        lazy = true,
        keys = {
            {"<leader>ic","<cmd>IconPickerNormal<CR>",desc = "Nomal Mode Pick Icon Insert Buffer"},
            {"<leader>iy","<cmd>IconPickerYank<CR>",desc = "Pick Icon And Yank To Regeister"}
        },
        dependencies = {"telescope.nvim"},
        opts = {
            disable_legacy_commands =true,
        }
    },
    -- 窗口选择器
    {
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        lazy = true,
        opts = {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
                bo = {
                    filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                    buftype = { 'terminal', "quickfix" },
                },
            },
            other_win_hl_color = '#e35e4f',
        }
    },
    -- 将缓冲区锁定到窗口
    {
        "stevearc/stickybuf.nvim",
        lazy = true,
        keys = {
            {"<leader>skf","<cmd>PinBuffer<CR>",desc = "Fix Before Buffer In Window"},
            {"<leader>skt","<cmd>PinBuftype<CR>",desc = "Set Before Buftype Fix In Window"},
            {"<leader>ske","<cmd>PinFiletype<CR>",desc = "Set Before Filetype Fix In Window"},
            {"<leader>sku","<cmd>UnpinBuffer<CR>",desc = "Cancel Everything Fix Window"}
        },
        opts = {}
    }
}
