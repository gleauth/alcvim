return {
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        lazy = true,
        ft = {"c","cpp","java","rust","javascript","typescript","json","css",
            "html","markdown","vim","yaml","toml","python","lua","sh","xml","cmake"},
        keys = {
            {"<leader>be","<cmd>Barbecue<CR>",desc = "Eject Barbecue Menu"},
        },
        dependencies = {
            {"nvim-navic"},
            {"nvim-web-devicons"},
            {"telescope.nvim"}
        },
        opts = {
            kinds = {
                File = "",
                Module = "",
                Namespace = "",
                Package = "",
                Class = "",
                Method = "",
                Property = "",
                Field = "",
                Constructor = "",
                Enum = "練",
                Interface = "練",
                Function = "",
                Variable = "",
                Constant = "",
                String = "",
                Number = "",
                Boolean = "◩",
                Array = "",
                Object = "",
                Key = "",
                Null = "ﳠ",
                EnumMember = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }
        }
    },
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        dependencies = {"nvim-lspconfig"},
        opts = {
            highlight = true
        }
    },
    {
        "SmiteshP/nvim-navbuddy",
        lazy = true,
        event = "LspAttach",
        dependencies = {
            {"nvim-lspconfig"},
            {"nvim-navic"},
            {"nui.nvim"},
        },
        opts = {
            window = {
                border = "rounded"
            },
            lsp = {
                auto_attach = true,
            }
        },
        keys = {
            {"<leader>ny","<cmd>Navbuddy<CR>",desc = "Show Navbuddy Interface"}
        }
    }
}
