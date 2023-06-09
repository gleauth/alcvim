-- buffer栏和status栏
return {
    -- buffer栏
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        event = "VeryLazy",
        init = function ()
            vim.keymap.set("n","<M-p>","<cmd>BufferLineCyclePrev<CR>",{desc = "Goto Prev Buffer"})
            vim.keymap.set("n","<M-n>","<cmd>BufferLineCycleNext<CR>",{desc = "Goto Next Buffer"})
            vim.keymap.set("n","<leader>bl","<cmd>BufferLineCloseLeft<CR>",{desc = "Close Left Buffer"})
            vim.keymap.set("n","<leader>br","<cmd>BufferLineCloseRight<CR>",{desc = "Close Right Buffer"})
        end,
        dependencies = {"nvim-web-devicons"},
        opts = {
            options = {
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                separator_style = "thin",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in ipairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or "")
                        s = s .. n .. sym
                    end
                    return s
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    }
                }
            }
        }
    },
    -- status栏插件
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {"nvim-web-devicons"},
        config = function()
            local lualine = require('lualine')
            local colors = {
                bg       = '#202328',
                fg       = '#bbc2cf',
                yellow   = '#ECBE7B',
                cyan     = '#008080',
                darkblue = '#081633',
                green    = '#98be65',
                orange   = '#FF8800',
                violet   = '#a9a1e1',
                magenta  = '#c678dd',
                blue     = '#51afef',
                red      = '#ec5f67',
            }
            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand('%:p:h')
                    local gitdir = vim.fn.finddir('.git', filepath .. ';')
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }
            local config = {
                options = {
                    component_separators = '',
                    section_separators = '',
                    theme = {
                        normal = { c = { fg = colors.fg, bg = colors.bg } },
                        inactive = { c = { fg = colors.fg, bg = colors.bg } },
                    },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {
                        {
                            function()
                                local key = require("grapple").key()
                                return "  [" .. key .. "]"
                            end,
                            cond = require("grapple").exists,
                        }
                    },
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {
                        {
                            require("noice").api.status.message.get_hl,
                            cond = require("noice").api.status.message.has,
                        },
                        {
                            require("noice").api.status.command.get,
                            cond = require("noice").api.status.command.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            require("noice").api.status.mode.get,
                            cond = require("noice").api.status.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            require("noice").api.status.search.get,
                            cond = require("noice").api.status.search.has,
                            color = { fg = "#ff9e64" },
                        }
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
            }
            local function ins_left(component)
                table.insert(config.sections.lualine_c, component)
            end
            local function ins_right(component)
                table.insert(config.sections.lualine_x, component)
            end
            ins_left {
                function()
                    return '▊'
                end,
                color = { fg = colors.blue },
                padding = { left = 0, right = 1 },
            }
            ins_left {
                function()
                    return ''
                end,
                color = function()
                    local mode_color = {
                        n = colors.red,
                        i = colors.green,
                        v = colors.blue,
                        [''] = colors.blue,
                        V = colors.blue,
                        c = colors.magenta,
                        no = colors.red,
                        s = colors.orange,
                        S = colors.orange,
                        [''] = colors.orange,
                        ic = colors.yellow,
                        R = colors.violet,
                        Rv = colors.violet,
                        cv = colors.red,
                        ce = colors.red,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ['r?'] = colors.cyan,
                        ['!'] = colors.red,
                        t = colors.red,
                    }
                    return { fg = mode_color[vim.fn.mode()] }
                end,
                padding = { right = 1 },
            }
            ins_left {
                'filesize',
                cond = conditions.buffer_not_empty,
            }
            ins_left {
                'filename',
                cond = conditions.buffer_not_empty,
                color = { fg = colors.magenta, gui = 'bold' },
            }
            ins_left { 'location' }
            ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
            ins_left {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                },
            }
            ins_left {
                function()
                    return '%='
                end,
            }
            ins_left {
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = ' LSP:',
                color = { fg = colors.green, gui = 'bold' },
            }
            ins_right {
                'o:encoding',
                fmt = string.upper,
                cond = conditions.hide_in_width,
                color = { fg = colors.green, gui = 'bold' },
            }
            ins_right {
                'fileformat',
                fmt = string.upper,
                icons_enabled = false,
                color = { fg = colors.green, gui = 'bold' },
            }
            ins_right {
                'branch',
                icon = '',
                color = { fg = colors.violet, gui = 'bold' },
            }
            ins_right {
                'diff',
                symbols = { added = ' ', modified = '柳 ', removed = ' ' },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = { fg = colors.red },
                },
                cond = conditions.hide_in_width,
            }
            ins_right {
                function()
                    return '▊'
                end,
                color = { fg = colors.blue },
                padding = { left = 1 },
            }
            lualine.setup(config)
        end
    }
}
