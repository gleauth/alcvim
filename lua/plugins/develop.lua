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
            cmake_command = "cmake",
            cmake_build_directory = "",
            cmake_build_directory_prefix = "cmake_build_",
            cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_options = {},
            cmake_console_size = 10,
            cmake_show_console = "always",
            cmake_dap_configuration = { name = "cpp", type = "lldb", request = "launch" },
            cmake_variants_message = {
                short = { show = true },
                long = { show = true, max_length = 40 }
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
            {"gR",mode = {"n","v"},desc = "Toggle Regexplainer"},
            {"gS",mode = {"n","v"},desc = "Show Regexplainer"},
            {"gH",mode = {"n","v"},desc = "Hide Regexplainer"},
            {"gP",mode = {"n","v"},desc = "Show_split Regexplainer"},
            {"gU",mode = {"n","v"},desc = "Show_popup Regexplainer"}
        },
        opts = {
            mappings = {
                toggle = "gR",
                show = "gS",
                hide = "gH",
                show_split = "gP",
                show_popup = "gU"
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
