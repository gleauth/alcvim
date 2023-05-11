-- 语言服务器增强插件
return {
    -- C/C++
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        ft = {"c","cpp"},
        init = function ()
            vim.keymap.set("n","<leader>cs","<cmd>ClangdSymbolInfo<CR>",{desc = "Show Cursor Local Symbol Info"})
            vim.keymap.set("n","<leader>cl","<cmd>ClangdTypeHierarchy<CR>",{desc = "Show Cursor Local Type Hierarchy"})
            vim.keymap.set("n","<leader>cg","<cmd>ClangdMemoryUsage expand_preamble<CR>",{desc = "Show Memory Use Status"})
        end,
        opts = {}
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
        init = function ()
            vim.keymap.set("n","<leader>yv","<cmd>YAMLView<CR>",{desc = "Show Current value pairs or key full path"})
            vim.keymap.set("n","<leader>yq","<cmd>YAMLQuickfix<CR>",{desc = "Genarates A Quickfix With key or Vaule Path"})
            vim.keymap.set("n","<leader>yt","<cmd>YAMLTelescope<CR>",{desc = "Full Path key or Value Fuzzy"})
        end
    }
}
