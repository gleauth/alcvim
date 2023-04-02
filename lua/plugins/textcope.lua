-- 字符处理: 跳转、修改、转换、搜索
return {
    -- 快速跳转
    {
        "phaazon/hop.nvim",
        branch = "v2",
        lazy = true,
        keys = {
            {"<leader>hw","<cmd>HopWord<CR>",desc = "Search And Jump Word"},
            {"<leader>hl","<cmd>HopLine<CR>",desc = "Search And Jump Line"},
            {"<leader>hc","<cmd>HopChar1<CR>",desc = "Search And Jump Char(input 1 char)"},
            {"<leader>hd","<cmd>HopChar2<CR>",desc = "Search And Jump Char(input 2 char)"},
            {"<leader>ht","<cmd>HopLineStart<CR>",desc = "Show Each Line 1st Non-blanke Char And Jump"},
            {"<leader>hv","<cmd>HopVertical<CR>",desc = "Show Cursor Local Char As Datum Jump"},
            {"<leader>hr","<cmd>HopPattern<CR>",desc = "Default Neovim Search And Jump Mix"},
            {"<leader>ha","<cmd>HopAnywhere<CR>",desc = "Jump AnyWhere"}
        },
        opts = {}
    },
    -- 文本内字符移动、跳转
    {
        "ggandor/leap.nvim",
        lazy = true,
        keys = {
            {"s",mode = {"n","o","x"},desc = "Leap ForWard To"},
            {"S",mode = {"n","o","x"},desc = "Leap BackWard To"},
            {"gs",mode = {"n","o","x"},desc = "Leap From Windows"}
        },
        dependencies = {
            {
                "ggandor/flit.nvim", --增强leap的f/T运动
                lazy = true,
                keys = function ()
                    local ret = {}
                    for _, key in ipairs({ "f", "F", "t", "T" }) do
                        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
                    end
                    return ret
                end,
                config = function ()
                    require("flit").setup({
                        labeled_modes = "nx",
                    })
                end
            }
        },
        config = function ()
            require("leap").add_default_mappings(true)
        end
    },
    -- 文本字符替换
    {
        "nvim-pack/nvim-spectre",
        lazy = true,
        keys = {
            {"<leader>so","<cmd>lua require('spectre').open()<CR>",desc = "Open Spectre"},
            {"<leader>sw","<cmd>lua require('spectre').open_visual({select_word=true})<CR>",desc = "Open Visual Select Word"},
            {"<leader>sf","viw:lua require('spectre').open_file_search()<CR>",desc = "Open File Search"},
            {"<leader>sh",mode = "v",desc = "Open Visual"}
        },
        config = function ()
            require("spectre").setup({
                mapping = {
                    ['toggle_line'] = {
                        map = "<leader>sd",
                    },
                    ['enter_file'] = {
                        map = "<leader>sg",
                    },
                    ["send_to_qf"] = {
                        map = "<leader>sq",
                    },
                    ['replace_cmd'] = {
                        map = "<leader>sn",
                    },
                    ['show_option_menu'] = {
                        map = "<leader>sm",
                    },
                    ['run_current_replace'] = {
                        map = "<leader>sc",
                    },
                    ['run_replace'] = {
                        map = "<leader>sa",
                    },
                    ['change_view_mode'] = {
                    map = "<leader>sv",
                    },
                    ['change_replace_sed'] = {
                        map = "ss",
                    },
                    ['change_replace_oxi'] = {
                        map = "<leader>sx",
                    },
                    ['toggle_live_update']={
                        map = "<leader>su",
                    },
                    ['toggle_ignore_case'] = {
                        map = "<leader>si",
                    },
                    ['toggle_ignore_hidden'] = {
                        map = "<leader>se",
                    },
                    ['resume_last_search'] = {
                        map = "<leader>sb",
                    },
                }
            })
            vim.keymap.set("v","<leader>sh","<esc>:lua require('spectre').open_visual()<CR>")
        end
    },
    -- 添加/更改/删除周围的定界符对
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = true,
        keys = {
            {"ys",mode = {"n","v"},desc = "add surround"},
            {"ds",mode = {"n","v"},desc = "delete surround"},
            {"cs",mode = {"n","v"},desc = "change quotes"}
        },
        opts = {}
    },
    -- 结构搜索和替换
    {
        "cshuaimin/ssr.nvim",
        lazy = true,
        keys = {
            {"<leader>sr",mode = {"n","x"},desc = "Structural Replace"}
        },
        config = function ()
            require("ssr").setup({
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "p",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                },
            })
            vim.keymap.set({"n","x"},"<leader>sr",function() require("ssr").open() end)
        end
    },
    -- 搜索时显示条目
    {
        "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        config = function ()
            require("scrollbar.handlers.search").setup({
                calm_down = true,
                nearest_only = true,
                nearest_float_when = "always",
                -- 自定义虚拟文本
                override_lens = function(render, posList, nearest, idx, relIdx)
                    local sfw = vim.v.searchforward == 1
                    local indicator, text, chunks
                    local absRelIdx = math.abs(relIdx)
                    if absRelIdx > 1 then
                        indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
                    elseif absRelIdx == 1 then
                        indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
                    else
                        indicator = ''
                    end

                    local lnum, col = unpack(posList[idx])
                    if nearest then
                        local cnt = #posList
                        if indicator ~= '' then
                            text = ('[%s %d/%d]'):format(indicator, idx, cnt)
                        else
                            text = ('[%d/%d]'):format(idx, cnt)
                        end
                        chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
                    else
                        text = ('[%s %d]'):format(indicator, idx)
                        chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
                    end
                    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                end
            })
            local kopts = {noremap = true,silent = true}
            vim.api.nvim_set_keymap('n', 'n',
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', 'N',
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '<Leader>hn', '<Cmd>nohlsearch<CR>',kopts)
        end
    },
    -- 字符、颜色、数字增量/减量
    {
        "monaqa/dial.nvim",
        lazy = true,
        keys = {
            {"<M-b>",mode = "n",desc = "Word Dial Inc"},
            {"<M-d>",mode = "n",desc = "Word Dial Dec"},
            {"<M-f>",mode = "n",desc = "Color Dial Inc"},
            {"<M-g>",mode = "n",desc = "Color Dial Dec"},
            {"<M-z>",mode = "n",desc = "Date Dial Inc"},
            {"<M-x>",mode = "n",desc = "Date Dial Dec"}
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group{
                -- 字符循环跳转
                chars_dial = {
                    augend.constant.new{elements={"+","-"},word=false,cyclic=true},
                    augend.constant.new{elements={"x","/"},word=false,cyclic=true},
                    augend.constant.new{elements={">","<"},word=false,cyclic=true},
                    augend.constant.new{elements={"=","!="},word=false,cyclic=true},
                    augend.constant.new{elements={"|","&"},word=false,cyclic=true},
                    augend.constant.new{elements={"||","&&"},word=false,cyclic=true},
                    augend.constant.new{elements={"true","false"},word=true,cyclic=true},
                    augend.constant.new{elements={"and","or"},word=true,cyclic=true},
                    augend.constant.new{elements={"if","else"},word=true,cyclic=true},
                    augend.constant.new{elements={"yes","no"},word=true,cyclic=true},
                    augend.constant.new{elements={"on","off"},word=true,cyclic=true},
                    augend.constant.new{elements={"left","right"},word=true,cyclic=true,},
                    augend.constant.new{elements={"out","in"},word=true,cyclic=true},
                    augend.constant.new{elements={"up","down"},word=true,cyclic=true},
                    augend.constant.new{elements={"disable","enable"},word=true,cyclic=true},
                    augend.constant.new{elements={"output","input"},word=true,cyclic=true},
                    augend.constant.new{elements={"front","rear"},word=true,cyclic=true},
                    augend.constant.new{elements={"start","end"},word=true,cyclic=true},
                    augend.constant.new{elements={"0","1","2","3","4","5","6","7","8","9"},word=false,cyclic=true},
                },
                -- 颜色增加或减少
                color_dial = {
                    augend.hexcolor.new{
                        case = "lower",
                    }
                },
                -- 日期增加/减少
                date_dial = {
                    augend.date.new{
                        pattern = "%Y/%m/%d",
                        default_kind = "day",
                        only_valid = true,
                        word = false,
                    }
                }
            }
            vim.keymap.set("n", "<M-b>", require("dial.map").inc_normal("chars_dial"), {noremap = true})
            vim.keymap.set("n", "<M-d>", require("dial.map").dec_normal("chars_dial"), {noremap = true})
            vim.keymap.set("n", "<M-f>", require("dial.map").inc_normal("color_dial"), {noremap = true})
            vim.keymap.set("n", "<M-g>", require("dial.map").dec_normal("color_dial"), {noremap = true})
            vim.keymap.set("n", "<M-z>", require("dial.map").inc_normal("date_dial"), {noremap = true})
            vim.keymap.set("n", "<M-x>", require("dial.map").dec_normal("date_dial"), {noremap = true})
        end
    }
}
