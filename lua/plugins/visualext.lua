return {
    -- 高度实验性插件
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function ()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    hover = {
                        silent = true,
                    }
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                views = {
                    split = {
                        enter = true
                    }
                }
            })
        end,
        keys = {
            {"<S-Enter>",function() require("noice").redirect(vim.fn.getcmdline()) end,mode = "c",desc = "Redirect Cmdline"},
            {"<leader>snl",function() require("noice").cmd("last") end,desc = "Noice Last Message"},
            {"<leader>snh",function() require("noice").cmd("history") end,desc = "Noice History"},
            {"<leader>sna",function() require("noice").cmd("all") end,desc = "Noice All"},
        }
    },
    -- 精美弹窗
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            stages = "fade",
            -- 消息框持续时间,默认5000(毫秒)
            timeout = 6000
        }
    },
    --光标行号模式指示器
    {
        "mawkler/modicator.nvim",
        lazy = true,
        init = function ()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        event = {"BufReadPost","BufNewFile"},
        opts = {
            highlishts = {
                defaults = {
                    bold = true
                },
            }
        }
    },
    -- 显示您的滚动或跳跃方向
    {
        "gen740/SmoothCursor.nvim",
        lazy = true,
        keys = {
            {"<leader>scs","<cmd>SmoothCursorStart<CR>",desc = "Start Smooth Cursor"},
            {"<leader>sct","<cmd>SmoothCursorStop<CR>",desc = "Stop Smooth Cursor"},
            {"<leader>sck","<cmd>SmoothCursorStop --keep-signs<CR>",desc = "Stop Smooth Cursor No Delete Signs"},
            {"<leader>scu","<cmd>SmoothCursorStatus<CR>",desc = "Show Smooth Cursor Status"},
            {"<leader>scg","<cmd>SmoothCursorToggle<CR>",desc = "Toggle Smooth Cursor"},
            {"<leader>scf","<cmd>SmoothCursorFancyToggle<CR>",desc = "Toggle Fancy Cursor"},
            {"<leader>scd","<cmd>SmoothCursorDeleteSigns<CR>",desc = "Delete All Signs"}
        },
        opts = {}
    },
    -- 突出显示文本
    {
        "Pocco81/high-str.nvim",
        lazy = true,
        cmd = {"HSHighlight","HSRmHighlight","HSImport"},
        opts = {
            verbosity = 0,
            saving_path = vim.fn.stdpath("cache") .. "/highstr",
            highlight_colors = {
                color_0 = {"#0c0d0e", "smart"},	-- Cosmic charcoal
                color_1 = {"#e5c07b", "smart"},	-- Pastel yellow
                color_2 = {"#7FFFD4", "smart"},	-- Aqua menthe
                color_3 = {"#8A2BE2", "smart"},	-- Proton purple
                color_4 = {"#FF4500", "smart"},	-- Orange red
                color_5 = {"#008000", "smart"},	-- Office green
                color_6 = {"#0000FF", "smart"},	-- Just blue
                color_7 = {"#FFC0CB", "smart"},	-- Blush pink
                color_8 = {"#FFF9E3", "smart"},	-- Cosmic latte
                color_9 = {"#7d5c34", "smart"},	-- Fallow brown
            }
        }
    },
    -- 显示十六进制颜色
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        keys = {
            {"<leader>crh","<cmd>ColorizerAttachToBuffer<CR>",desc = "Show Highlight"},
            {"<leader>crr","<cmd>ColorizerReloadAllBuffers<CR>",desc = "Load All Buffer HSHighlight"},
            {"<leader>crd","<cmd>ColorizerDetachFromBuffer<CR>",desc = "Detach Buffer HSHighlight"},
            {"<leader>crt","<cmd>ColorizerToggle<CR>",desc = "Toggle Buffer HSHighlight"}
        },
        opts = {
            filetypes = {
                '*';
                cmp_docs = {always_update = true}
            },
            user_default_options = {
                RRGGBBAA = true,
                AARRGGBB = true,
                tailwind = true,
            }
        }
    },
    -- 显示缩进线
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        config = function ()
            require("indent_blankline").setup({
                -- 显示当前所在区域
                show_current_context = true,
                -- 显示当前所在区域的开始位置
                show_current_context_start = true,
                -- 显示行尾符
                show_end_of_line = true,
                -- 空格字符缩进样式
                space_char_blankline = " ",
            })
        end
    },
    -- 显示滚动条
    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        config = function()
            local colors = {
                Handle = "#892E42",
                Search = "#FFC860",
                Error  = "#FD6883",
                Warn   = "#FFD886",
                Info   = "#A9DC76",
                Hint   = "#78DCE8",
                Misc   = "#AB9DF2"
            }
            require("scrollbar").setup({
                handle = {
                    -- 滚动条颜色
                    color  = colors.Handle
                },
                marks = {
                    -- 诊断颜色
                    Search = {color = colors.Search},
                    Error  = {color = colors.Error},
                    Warn   = {color = colors.Warn},
                    Info   = {color = colors.Info},
                    Hint   = {color = colors.Hint},
                    Misc   = {color = colors.Misc}
                },
                handlers = {
                    gitsigns = true,
                    search = true,
                }
            })
        end
    },
    -- 显示光标下相同词汇
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        config = function ()
            require("illuminate").configure()
        end,
        keys = {
            {"<leader>ig","<cmd>IlluminateToggle<CR>",desc = "Toggle Illuminate"},
            {"<leader>ib","<cmd>IlluminateToggleBuf<CR>",desc = "Toggle Local Buffer Illuminate"}
        }
    }
}
