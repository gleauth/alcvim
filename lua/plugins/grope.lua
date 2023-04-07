return {
   -- telescope模糊查找
   {
        "nvim-telescope/telescope.nvim",
        branch="0.1.x",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            --neovim核心内容可以填充到telescope
            {"nvim-telescope/telescope-ui-select.nvim",lazy = true},
            --支持的文件和文件夹的同步创建、删除、重命名和移动
            {"nvim-telescope/telescope-file-browser.nvim",lazy = true},
            --在编辑历史中选择文件时提供智能优先级排序(以频率和新近度排序)
            {"nvim-telescope/telescope-frecency.nvim",lazy = true},
            {"plenary.nvim"}
        },
        config = function()
            local trouble = require("trouble.providers.telescope")
            require('telescope').setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<c-H>"] = "which_key",
                            ["<c-T>"] = trouble.open_with_trouble,
                        },
                        n = {
                            ["<c-T>"] = trouble.open_with_trouble
                        },
                    }
                },
                pickers = {
                    find_files = {
                        theme = "ivy"
                    }
                },
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        mappings = {
                            ["i"] = {},
                            ["n"] = {},
                        },
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- cmake-tools插件需要用到
                            width = 0.8,
                            previewer = false,
                            prompt_title = false,
                            borderchars = {
                                { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                                prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                                results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                            }
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("frecency")
            require('telescope').load_extension("projects")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("harpoon")
            require("telescope").load_extension("yank_history")
        end,
        keys = {
            {"<leader>tsw","<cmd>Telescope find_files theme=ivy<CR>",desc = "Find Files"},
            {"<leader>tsg","<cmd>Telescope live_grep theme=ivy<CR>",desc = "Grep Word"},
            {"<leader>tsb","<cmd>Telescope buffers theme=ivy<CR>",desc = "Find Buffers"},
            {"<leader>tsh","<cmd>Telescope help_tags theme=ivy<CR>",desc = "Find Help Tags"},
            {"<leader>tso","<cmd>Telescope oldfiles theme=ivy<CR>",desc = "Find Old Files"},
            {"<leader>tsm","<cmd>Telescope marks theme=ivy<CR>",desc = "Find Marks"},
            {"<leader>tsn","<cmd>Telescope notify theme=ivy<CR>",desc = "Find Notify History"},
            {"<leader>tsp","<cmd>Telescope projects<CR>",desc = "Find Projects"},
            {"<leader>tse","<cmd>Telescope file_browser<CR>",desc = "Find File browser Tree"},
            {"<leader>tss","<cmd>Telescope harpoon<CR>",desc = "Find Harpoon File Marks"},
            {"<leader>tsr","<cmd>Telescope frecency theme=ivy<CR>",desc = "Find Frecency"},
            {"<leader>tsy","<cmd>Telescope yank_history<CR>",desc = "Find Yank History"}
        }
    },
    -- fzf模糊查找
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        cmd = "FzfLua",
        keys = {
            {"<leader>fl","<cmd>FzfLua<CR>",desc = "Open Fzf inquiry"},
            {"<leader>ff","<cmd>FzfLua files<CR>",desc = "Fzf inquiry files"},
            {"<leader>fb","<cmd>FzfLua buffers<CR>",desc = "Fzf inquiry buffers"},
            {"<leader>fa","<cmd>FzfLua args<CR>",desc = "Show Fzf args list"},
            {"<leader>fh","<cmd>FzfLua oldfiles<CR>",desc = "Show files history"},
            {"<leader>fq","<cmd>FzfLua quickfix<CR>",desc = "Open quickfix list"},
            {"<leader>ft","<cmd>FzfLua tabs<CR>",desc = "Fzf inquiry tab list"}
        },
        opts = {
            winopts = {
                hl = {
                    border = "FloatBorder",
                },
                preview = {
                    winopts = {
                        relativenumber = true,
                    }
                }
            }
        }
    }
}
