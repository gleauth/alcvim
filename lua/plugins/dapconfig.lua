return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        cmd = {"DapTerminate","DapSetLogLevel","DapRestartFrame"},
        keys = {
            {"<F5>","<cmd>DapContinue<CR>",desc = "Start Debug Or Gogo Next Continue"},
            {"<F6>","<cmd>DapStepInto<CR>",desc = "Single Step And Into"},
            {"<F7>","<cmd>DapStepOver<CR>",desc = "Single Step And Over"},
            {"<F8>","<cmd>DapStepOut<CR>",desc = "Step Out of Current Function"},
            {"<leader>dr",mode = "n",desc="Restart Debug"},
            {"<F10>","<cmd>lua require('dap').close<CR>",desc = "Close Debug"},

            {"<leader>db","<cmd>DapToggleBreakpoint<CR>",desc = "Toggle Break Point"},
            {"<leader>dm",mode = "n",desc="Log Point Message"},
            {"<leader>dj","<cmd>DapLoadLaunchJSON<CR>",desc = "Direct Load Json File Debug"},
            {"<leader>dg","<cmd>DapShowLog<CR>",desc = "Show Debug Log"},

            {"<leader>dvt","<cmd>DapVirtualTextToggle<CR>",desc = "Toggle Show Virtual Text"},
            {"<leader>dvf","<cmd>DapVirtualTextForceRefresh<CR>",desc = "Force Refresh Virtual Text"},

            {"<leader>dt","<cmd>DapToggleRepl<CR>",desc="Toggle Repl"},
            -- 小部件UI
            {"<leader>dh",mode = {"n","v"},desc="dap.ui.widgets hover"},
            {"<Leader>dp",mode = {"n","v"},desc="dap.ui.widgets preview"},
            {"<Leader>dc",mode = {"n"},desc="dap.ui.widgets float centered frames"},
            {'<Leader>ds',mode = {"n"},desc="dap.ui.widgets float centered scopes"}
        },
        dependencies = {
            {"nvim-dap-ui"},
            -- {"nvim-dap-virtual-text"},
            {"telescope.nvim"}
        },
        config = function ()
            require("debugger.dapsettings")
            require("debugger.dapstartup")
            vim.keymap.set("n","<leader>dr",function()
                require("dap").run_last()
            end)
            vim.keymap.set("n","<leader>dm",function()
                require("dap").set_breakpoint(nil,nil,vim.fn.input('Log point message: '))
            end)
            -- 小部件UI
            vim.keymap.set({'n', 'v'},"<Leader>dh",function()
                require('dap.ui.widgets').hover()
            end)
            vim.keymap.set({'n', 'v'}, '<Leader>dp',function()
                require('dap.ui.widgets').preview()
            end)
            vim.keymap.set('n', '<Leader>dc',function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds',function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)
        end
    },
    -- 调试UI界面
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        keys = {
            {"<leader>du","<cmd>lua require('dapui').toggle()<CR>",desc="Dapui Toggle"}
        },
        config = function ()
            require("debugger.dapuisettings")
        end
    },
    -- 虚拟文本
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = true,
            only_first_definition = true,
            all_references = true,
            display_callback = function (variable, _buf, _stackframe, _node)
                return variable.name .. '=' .. variable.value
            end,
            virt_text_pos = 'eol',
            all_frames = true,
            virt_lines = true,
            virt_text_win_col = nil
        }
    },
    ------ 特定语言调试需要用到的插件 ------
    -- lua
    {
        "jbyuki/one-small-step-for-vimkind",
        lazy = true,
        keys = {
            {"<leader>dlr","<cmd>lua require('osv').run_this()<CR>",desc="Lua Debug Run"},
            {"<leader>dlt","<cmd>lua require('osv').start_trace()<CR>",desc="Lua Debug Start Trace"},
            {"<leader>dls","<cmd>lua =require('osv').stop_trace()<CR>",desc="Lua Debug Stop Trace"},
            {"<leader>dll","<cmd>lua require('osv').launch({port = 8086})<CR>",desc = "Lua Debug Launch"}
        },
        dependencies = "nvim-dap"
    }
}
