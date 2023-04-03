-- nvim-cmp的补全及其代码片段插件
return {
    -- 代码片段支持
    {
        "L3MON4D3/luasnip",
        build = "make install_jsregexp",
        event = "InsertEnter",
        dependencies = {
            "rafamadriz/friendly-snippets", --提供多种语言的代码片段
        },
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip").setup({
                history = true,
                delete_check_events = "TextChanged"
            })
        end
    },
     --代码补全插件
    {
        "hrsh7th/nvim-cmp",  --代码补全
        event = {"InsertEnter","CmdlineEnter"},
        dependencies = {
            {"onsails/lspkind-nvim",lazy = true}, --为补全添加类似vscode的图标
            {"saadparwaiz1/cmp_luasnip",lazy = true}, --luasnip补全源
            {"hrsh7th/cmp-nvim-lsp",lazy = true}, --替换内置omnifunc,获得更多补全
            {"hrsh7th/cmp-buffer",lazy = true}, --缓冲区补全
            {"hrsh7th/cmp-cmdline",lazy = true}, --命令补全
            {"hrsh7th/cmp-path",lazy = true}, --路径补全
            {"lukas-reineke/cmp-rg",lazy = true}, --rg补全源
            {"f3fora/cmp-spell",lazy = true}, --拼写建议
            {"lukas-reineke/cmp-under-comparator"}, --更好的排序
        },
        config = function()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local handlers = require('nvim-autopairs.completion.handlers')
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                sources = cmp.config.sources({
                    {
                        name = "luasnip",
                        option = {
                            use_show_condition = false,
                            show_autosnippets = true
                        }
                    },
                    {name = "nvim_lsp"},
                    {name = "path"},
                    {
                        name = "buffer",
                        option = {
                            keyword_pattern = [[\k\+]],
                            get_bufnrs = function()
                                local bufs = {}
                                for _, win in ipairs(vim.api.nvim_list_wins()) do
                                    bufs[vim.api.nvim_win_get_buf(win)] = true
                                end
                                return vim.tbl_keys(bufs)
                            end
                        }
                    },
                    {
                        name = "rg",
                        keyword_length = 3
                    },
                    {name = "spell"},
                    {name = "crates"}
                }),
                -- 格式化补全菜单
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        with_text = true,
                        maxwidth = 50,
                        ellipsis_char = '...',
                        before = function(entry, vim_item)
                            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                            return vim_item
                        end
                    })
                },
                experimental = {
                    ghost_text = {
                        hl_group = "LspCodeLens"
                    }
                },
                -- 对补全建议排序
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        require "cmp-under-comparator".under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order
                    }
                },
                -- 绑定补全相关的按键
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),    --Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),     --Down
                    -- C-b (back) C-f (forward) for snippet placeholder navigation.
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),            --关闭补全
                    ["<C-p>"] = cmp.mapping.select_prev_item(), --选择上一个
                    ["<C-n>"] = cmp.mapping.select_next_item(), --选择下一个
                    ["<CR>"] = cmp.mapping.confirm {            --确认选择
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end,{"i", "s"}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"})
                })
            })
            -- 命令行 / ? 模式提示
            cmp.setup.cmdline({"/","?"},{
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources(
                        {
                            {name = "buffer"}
                        }
                    )
                }
            )
            -- 命令行 : 模式提示
            cmp.setup.cmdline(":",{
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources(
                        {
                            {name = "path"}
                        },
                        {
                            {name = "cmdline"}
                        }
                    )
                }
            )
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    filetypes = {
                        ["*"] = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method,
                                },
                                handler = handlers["*"]
                            }
                        },
                        lua = {
                            ["("] = {
                                kind = {
                                    cmp.lsp.CompletionItemKind.Function,
                                    cmp.lsp.CompletionItemKind.Method
                                },
                                handler = function(char, item, bufnr, rules, commit_character)
                                end
                            }
                        },
                        tex = false
                    }
                })
            )
        end
    }
}
