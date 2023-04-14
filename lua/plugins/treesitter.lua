-- 依赖treesitter才能使用的插件
return {
    -- 语法高亮
    {
        "nvim-treesitter/nvim-treesitter",
        build = {":TSUpdate"},
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        cmd = {"TSUpdate","TSUpdateSync"},
        dependencies = {
            --语法感知文本对象、选择、移动、交换和查看支持
            {"nvim-treesitter/nvim-treesitter-textobjects",lazy = true},
            -- 根据光标在文件中的位置设置注释字符串
            {"JoosepAlviste/nvim-ts-context-commentstring",lazy = true},
            -- 彩虹括号
            {"HiPhish/nvim-ts-rainbow2",lazy = true},
            -- 自动关闭和重命名html标签
            {"windwp/nvim-ts-autotag",lazy = true},
            -- 重构模块
            {"nvim-treesitter/nvim-treesitter-refactor",lazy = true},
            -- 自动添加end
            {"RRethy/nvim-treesitter-endwise",lazy = true}
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- 同步下载高亮支持
                sync_install = true,
                -- 安装高亮支持文件
                ensure_installed = {
                    "c","cpp","python","java","cmake","lua","vim","bash","fish","vue","yaml","toml",
                    "markdown","markdown_inline","regex","json","javascript","typescript","css","html","norg"
                },
                -- 忽略安装
                ignore_install = {},
                -- 自动安装
                auto_install = true,
                -- 高亮相关
                highlight = {
                    -- 启用高亮支持
                    enable = true,
                    -- 使用treesitter高亮而不是neovim内置的高亮
                    additional_vim_regex_highlighting = false,
                },
                -- 范围选择
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        -- 初始化选择
                        init_selection = "gnn",
                        -- 递增
                        node_incremental = "grn",
                        -- 递减
                        node_decremental = "grc",
                        -- 选择一个范围
                        scope_incremental = "grm"
                    }
                },
                indent = {
                    enable = true
                },
                autotag = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    query = "rainbow-parens",
                    strategy = require 'ts-rainbow.strategy.global',
                },
                endwise = {
                    enable = true
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        clear_on_cursor_move = true,
                    },
                    highlight_current_scope = {
                        enable = false,
                    },
                    smart_rename = {
                        enable = true,
                        keymaps = {
                            smart_rename = "grr"
                        }
                    },
                    navigation = {
                        enable = true,
                        keymaps = {
                            goto_definition = "gnd",
                            list_definitions = "gnD",
                            list_definitions_toc = "gO",
                            goto_next_usage = "<M-*>",
                            goto_previous_usage = "<M-#>",
                        }
                    }
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = '<M-v>',
                        },
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>aa"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                            ["]o"] = "@loop.*",
                            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                        goto_next = {
                            ["]d"] = "@conditional.outer",
                        },
                        goto_previous = {
                            ["[d"] = "@conditional.outer",
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'rounded',
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        }
                    }
                }
            })
        end
    },
    ------ 依赖于treesitter的插件,需要配置选项 ------
    -- 突出显示参数的定义和用法
    {
        "m-demare/hlargs.nvim",
        lazy = true,
        ft = {"c","cpp","go","java","javascript","jsx","lua","python","tsx","typescript","vim"},
        dependencies = {"nvim-treesitter"},
        opts = {},
        keys = {
            {"<leader>hg","<cmd>lua require('hlargs').toggle()<CR>",desc = "Toggle File Highlight Args"}
        }
    },
    -- 在函数、方法、语句等之后显示当前上下文的虚拟文本
    {
        "haringsrob/nvim_context_vt",
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        dependencies = {"nvim-treesitter"},
        opts = {
            prefix = "",
            disable_ft = {"markdown","yaml","toml","ini","help"},
            disable_virtual_lines_ft = {"yaml","python","toml"},
        },
        keys = {
            {"<leader>nv","<cmd>NvimContextVtToggle<CR>",desc = "Toggle Context Virtual Text"}
        }
    },
    -- 将函数头显示在界面前几行
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = {"BufReadPost","BufNewFile"},
        dependencies = {"nvim-treesitter"},
        opts = {},
        keys = {
            {"<leader>tc","<cmd>TSContextToggle<CR>",desc = "Toggle Show Current Buffer Context"}
        }
    }
}
