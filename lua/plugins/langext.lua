-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = {"c","cpp"},
        opts = {},
        keys = {
            {"<leader>cs","<cmd>ClangdSymbolInfo<CR>",desc = "Show Cursor Local Symbol Info"},
            {"<leader>cl","<cmd>ClangdTypeHierarchy<CR>",desc = "Show Cursor Local Type Hierarchy"},
            {"<leader>cg","<cmd>ClangdMemoryUsage expand_preamble<CR>",desc = "Show Memory Use Status"}
        }
    },
    -- java
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java",
        config = function ()
            require("ftplugin.java")
        end
    },
    -- yaml
    {
        "cuducos/yaml.nvim",
        lazy = true,
        ft = "yaml",
        keys = {
            {"<leader>yv","<cmd>YAMLView<CR>",desc = "Show Current value pairs or key full path"},
            {"<leader>yq","<cmd>YAMLQuickfix<CR>",desc = "Genarates A Quickfix With key or Vaule Path"},
            {"<leader>yt","<cmd>YAMLTelescope<CR>",desc = "Full Path key or Value Fuzzy"}
        }
    },
    -- rust
    {
        "Saecki/crates.nvim",
        lazy = true,
        event = {"BufRead Cargo.toml"},
        opts = {}
    }
}
