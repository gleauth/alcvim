return {
    -- cmake工具集成
    {
        "Civitasv/cmake-tools.nvim",
        lazy = true,
        keys = {
            {"<leader>cmb","<cmd>CMakeBuild<CR>",desc = "Build CMake Project"},
            {"<leader>cmr","<cmd>CMakeRun<CR>",desc = "Run CMake Project"},
            {"<leader>cmd","<cmd>CMakeDebug<CR>",desc = "Debug CMake Project"},
            {"<leader>cmk","<cmd>CMakeSelectKit<CR>",desc = "Select Custom Kit"},
            {"<leader>cmo","<cmd>CMakeOpen<CR>",desc = "Open CMake Console"},
            {"<leader>cmc","<cmd>CmakeClose<CR>",desc = "Close CMake Console"},
            {"<leader>cms","<cmd>CMakeStop<CR>",desc = "Stop CMake"}
        },
        opts = {
            cmake_compile_commands_from_lsp = true,
            cmake_dap_configuration = {
                name = "cpp",
                type = "lldb-vscode",
                request = "launch"
            }
        }
    },
    -- 工程管理
    {
        "ahmedkhalf/project.nvim",
        event = "VimEnter",
        config = function ()
            require("project_nvim").setup()
        end
    },
    -- 正则表达式解释器
    {
        "bennypowers/nvim-regexplainer",
        lazy = true,
        keys = {
            {"gR",mode = {"n"},desc = "Toggle Regexplainer"},
            {"gS",mode = {"n"},desc = "Show Regexplainer"},
            {"gH",mode = {"n"},desc = "Hide Regexplainer"},
            {"gL",mode = {"n"},desc = "Show_split Regexplainer"},
            {"gP",mode = {"n"},desc = "Show_popup Regexplainer"}
        },
        opts = {
            mappings = {
                toggle = "gR",
                show = "gS",
                hide = "gH",
                show_split = "gL",
                show_popup = "gP"
            },
            narrative = {
                separator = function(component)
                    local sep = '\n'
                    if component.depth > 0 then
                        for _ = 1, component.depth do
                            sep = sep .. '> '
                        end
                    end
                    return sep
                end
            }
        }
    },
    -- 提供对SchemaStore目录的访问
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        ft = {"json","yaml"}
    },
    -- 代替内置make命令
    {
        "neomake/neomake",
        event = "VeryLazy"
    }
}
