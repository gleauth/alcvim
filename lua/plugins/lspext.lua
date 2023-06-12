return {
    -- LSP 进度提示
    {
        "j-hui/fidget.nvim",
        version = "legacy",
        lazy = true,
        event = "LspAttach",
        opts = {
            window = {
                border = "rounded"
            },
            debug = {
                logging = true,
                strict = true,
            }
        }
    },
    -- 灯泡提示代码行为
    {
        "kosayoda/nvim-lightbulb",
        lazy = true,
        event = "LspAttach",
        config = function ()
            require("nvim-lightbulb").setup({
                autocmd = {enabled = true}
            })
        end
    },
    -- 显示元信息和差异预览的代码操作的弹出菜单
    {
        "weilbith/nvim-code-action-menu",
        lazy = true,
        cmd = "CodeActionMenu",
        keys = {
            {"<leader>ca","<cmd>CodeActionMenu<CR>",desc = "Show Code Action Menu"}
        }
    },
    -- 基于LSP带有即时视觉反馈的重命名
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        cmd = "IncRename",
        keys = {
            {"<leader>rn",":IncRename ",desc = "Inc Rename"},
        },
        config = function ()
            require("inc_rename").setup({
                preview_empty_name = true,
            })
        end
    },
    -- 增强Lspconfig插件的效果
    {
        "glepnir/lspsaga.nvim",
        lazy = true,
        cmd = "Lspsaga",
        keys = {
            -- 诊断跳转，<c-o>跳回
            {"]e","<cmd>Lspsaga diagnostic_jump_prev<CR>",desc = "Diagnotics Jump Prev"},
            {"[e","<cmd>Lspsaga diagnostic_jump_next<CR>",desc = "Diagnotics Jump Next"},
            {"<leader>lga","<cmd>Lspsaga code_action<CR>",desc = "Lspsaga Show Code Action"},
            {"<leader>lgb","<cmd>Lspsaga show_buf_diagnostics<CR>",desc = "Show Buffer Diagnotics"},
            {"<leader>lgd","<cmd>Lspsaga show_cursor_diagnostics<CR>",desc = "Show Cursor Local Diagnotics"},
            {"<leader>lgr","<cmd>Lspsaga rename<CR>",desc = "Lspsaga Rename"},
            {"<leader>lgp","<cmd>Lspsaga rename ++project<CR>",desc = "Lspsaga Rename Project"},
            {"<leader>lgf","<cmd>Lspsaga peek_definition<CR>",desc = "Peek Definition"},
            {"<leader>lgg","<cmd>Lspsaga goto_definition<CR>",desc = "Goto Definition"},
            {"<leader>lgy","<cmd>Lspsaga peek_type_definition<CR>",desc = "Peek Type Definition,<C-t> BackWard"},
            {"<leader>lgx","<cmd>Lspsaga goto_type_definition<CR>",desc = "Goto Type Definition"},
            {"<leader>lgh","<cmd>Lspsaga hover_doc<CR>",desc = "Show Hover Doc"},
            {"<leader>lgk","<cmd>Lspsaga hover_doc ++keep<CR>",desc = "Hover In Upper Right Corner"},
            {"<leader>lgl","<cmd>Lspsaga show_line_diagnostics<CR>",desc = "Show Line Diagnotics"},
            {"<leader>lgo","<cmd>Lspsaga outline<CR>",desc = "Lspsaga Toggle Outline"},
            {"<Leader>lgi","<cmd>Lspsaga incoming_calls<CR>",desc = "Call Incoming"},
            {"<Leader>lgt","<cmd>Lspsaga outgoing_calls<CR>",desc = "Call Outgoing"},
            {"<leader>lgm","<cmd>Lspsaga term_toggle<CR>",desc = "Lspsaga Float Terminal"},
            {"<leader>lgn","<cmd>Lspsaga lsp_finder<CR>",desc = "Search Finder Definition,<C-t> BackWard"}
        },
        init = function ()
            -- 带过滤器的诊断跳转，如之跳转到错误处
            vim.keymap.set("n", "[E", function()
                require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            end,{desc = "Goto Prev Diagnotics Serverity ERROR"})
            vim.keymap.set("n", "]E", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end,{desc = "Goto Next Diagnotics Serverity ERROR"})
        end,
        dependencies = {
            {"nvim-web-devicons"},
            {"nvim-treesitter"}
        },
        config = function ()
            require("lspsaga").setup({
                ui = {
                    border = "rounded"
                }
            })
        end
    },
    -- 显示函数的引用和定义信息
    {
        "VidocqH/lsp-lens.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
            include_declaration = true,
            sections = {
                definition = true
            }
        }
    },
    -- 代码大纲
    {
        "stevearc/aerial.nvim",
        lazy = true,
        keys = {
            {"<leader>ag","<cmd>AerialToggle<CR>",desc = "Toggle Aerial"},
            {"<leader>ao","<cmd>AerialOpenAll<CR>",desc = "Open All Aerial"},
            {"<leader>ac","<cmd>AerialCloseAll<CR>",desc = "Close All Aerial"},
            {"<leader>ai","<cmd>AeriaInfo<CR>",desc = "Show Aerial Info"}
        },
        config = function ()
            require("aerial").setup({
                layout = {
                    min_width = 20,
                    default_direction = "prefer_left",
                },
                show_guides = true,
                on_attach = function(bufnr)
                    vim.keymap.set("n","{","<cmd>AeriaPrev<CR>",{buffer = bufnr})
                    vim.keymap.set("n","}","<cmd>AeriaNext<CR>",{buffer = bufnr})
                end
        })
        end
    },
    -- 使用lsp生成的视图符号
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        keys = {
            {"<leader>syo","<cmd>SymbolsOutlineOpen<CR>",desc = "Open Symbols Outline"},
            {"<leader>syc","<cmd>SymbolsOutlineClose<CR>",desc = "Close Symbols Outline"},
            {"<leader>syl","<cmd>SymbolsOutline<CR>",desc = "Switch Symbols Outline"}
        },
        config = function ()
            local config = {
                width = 30,
                show_numbers = true,
                show_relative_numbers = true,
                keymaps = {
                    close = {"<Esc>", "q"},
                    goto_location = "<CR>",
                    focus_location = "O",
                    hover_symbol = "<M-H>",
                    toggle_preview = "X",
                    rename_symbol = "R",
                    code_actions = "A",
                    fold = "h",
                    unfold = "l",
                    fold_all = "W",
                    unfold_all = "E",
                    fold_reset = "R",
                },
            }
            require("symbols-outline").setup(config)
        end
    },
    --显示代码诊断, 参考, telescope结果, quickfix和位置列表
    {
        "folke/trouble.nvim",
        lazy = true,
        cmd = {"TroubleToggle","Trouble","TroubleRefresh","TroubleClose"},
        keys = {
            {"<leader>xt","<cmd>TroubleToggle<CR>",desc = "Toggle Diagnotics List"},
            {"<leader>xr","<cmd>TroubleRefresh<CR>",desc = "Refresh Action List"},
            {"<leader>xw","<cmd>TroubleToggle workspace_diagnostics<CR>",desc = "Lsp Workspace Diagnotics"},
            {"<leader>xd","<cmd>TroubleToggle document_diagnostics<CR>",desc = "Lsp Document Diagnostics"},
            {"<leader>xn","<cmd>TroubleToggle lsp_definitions<CR>",desc = "Lsp Cursor Word Definition"},
            {"<leader>xf","<cmd>TroubleToggle lsp_references<CR>",desc = "Lsp Cursor Word References"},
            {"<leader>xq","<cmd>TroubleToggle quickfix<CR>",desc = "Window Quickfix Project"},
            {"<leader>xl","<cmd>TroubleToggle loclist<CR>",desc = "Window Local List Project"}
        },
        opts = {
            action_keys = {
                close = "q",
                cancel = "<Esc>",
                refresh = "r",
                jump = {"<Tab>", "<leader><Tab>"},
                open_split = { "<C-X>" },
                open_vsplit = { "<C-L>" },
                open_tab = { "<space>" },
                jump_close = {"o"},
                toggle_mode = "m",
                toggle_preview = "P",
                hover = "K",
                preview = "p",
                close_folds = {"zM", "zm"},
                open_folds = {"zR", "zr"},
                toggle_fold = {"zA", "za"},
                previous = "k",
                next = "j"
            },
            use_diagnostic_signs = true
        }
    }
}
