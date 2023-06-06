return {
    --侧边栏
    {
        "sidebar-nvim/sidebar.nvim",
        lazy = true,
        cmd = "SidebarNvimToggle",
        keys = {
            {"<leader>sbt","<cmd>SidebarNvimToggle<CR>",desc = "Toggle SideBar"},
            {"<leader>sbu","<cmd>SidebarNvimUpdate<CR>",desc = "Update SideBar"},
            {"<leader>sbf","<cmd>SidebarNvimFocus<CR>",desc = "Focus Sidebar"},
            {"<leader>sbr",":SidebarNvimResize ",desc = "Resize Sidebar"}
        },
        opts = {}
    },
    -- 终端
    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        version = '*',
        cmd = {"ToggleTerm","TermExec","ToggleTermToggleAll","ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines","ToggleTermSendVisualSelection"},
        keys = {
            {"<leader>ttf","<cmd>ToggleTerm<CR>",desc = "Open Float Terminal"},
            {"<leader>ttg","<cmd>lua _lazygit_toggle()<CR>",desc="Open Lazygit Terminal"},
            {"<leader>tte",":TermExec ",desc = "Use Custom Operate Open Terminal"}
        },
        config = function()
            local Terminal  = require('toggleterm.terminal').Terminal
            -- 自定义lazygit终端
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                dir = "git_dir",
                -- 默认使用浮动终端
                direction = "float",
                float_opts = {
                    border = "rounded",
                }
            })
            function _lazygit_toggle()
                lazygit:toggle()
            end
            require("toggleterm").setup({
                persist_size = false,
                -- 默认使用浮动终端
                direction = "float",
                float_opts = {
                    border = "shadow"
                },
                winbar = {
                    enable = true
                }
            })
        end
    },
    -- 文件目录树
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        lazy = true,
        cmd = "Neotree",
        keys = {
            {"<leader>nt","<cmd>Neotree<CR>",desc = "Open Neo Tree"},
            {"<leader>nc","<cmd>Neotree close<CR>",desc = "Close Neo Tree"},
            {"<leader>nf","<cmd>Neotree float<CR>",desc = "Open Float Tree"},
            {"<leader>ng","<cmd>Neotree toggle<CR>",desc = "Toggle Tree"},
            {"<leader>nb","<cmd>Neotree buffers<CR>",desc = "Show Buffers Tree"},
            {"<leader>nr","<cmd>Neotree filesystem reveal right<CR>",desc = "Select Right Open Tree"}
        },
        dependencies = {
            {"nvim-web-devicons"},
            {"plenary.nvim"},
            {"nui.nvim"}
        },
        init = function ()
            vim.g.neo_tree_remove_legacy_commands = true
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            filesystem = {
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            default_component_configs = {
                indent = {
                    with_expander = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                }
            },
            source_selector = {
                winbar = true,
                statusline = true
            }
        }
    },
    -- 在悬浮窗中运行ranger
    {
        "kevinhwang91/rnvimr",
        lazy = true,
        keys = {
            {"<leader>rv","<cmd>RnvimrToggle<CR>",desc="Swith Ranger in Float Window"}
        }
    },
    -- 屏保
    {
        "folke/drop.nvim",
        event = "VimEnter",
        config = function ()
            math.randomseed(os.time())
            local themes = ({"stars","snow","xmas","leaves"})[math.random(1,4)]
            require("drop").setup({
                theme = themes,
            })
        end
    },
    -- 显示界面
    {
        "echasnovski/mini.starter",
        version = false,
        event = "VimEnter",
        opts = function()
            local logo = table.concat({
                "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
            }, "\n")
            local pad = string.rep(" ", 0)
            local new_section = function(name, action, section)
                return { name = name, action = action, section = pad .. section }
            end

            local starter = require("mini.starter")
            local config = {
                evaluate_single = true,
                header = logo,
                items = {
                    new_section("Find file ",         "Telescope find_files", "Inquiry"),
                    new_section("Recent files ",      "Telescope oldfiles",   "Inquiry"),
                    new_section("Grep text ",         "Telescope live_grep",  "Inquiry"),
                    new_section("Open last projects ","Telescope projects",   "Inquiry"),
                    new_section("MRU ",               "Telescope frecency",   "Inquiry"),
                    new_section("Settings ",          "e $MYVIMRC",           "Config"),
                    new_section("Lazy 鈴",             "Lazy",                 "Config"),
                    new_section("New file ",          "ene | startinsert",    "Built-in"),
                    new_section("Quit ",              "qa",                   "Built-in"),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(pad .. "░ ", false),
                    starter.gen_hook.aligning("center", "center"),
                },
            }
            return config
        end,
        config = function(_, config)
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "MiniStarterOpened",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
            local starter = require("mini.starter")
            starter.setup(config)
        end
    }
}
