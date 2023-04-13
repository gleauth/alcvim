local settings = {
    dev = {
        path = vim.fn.stdpath("data") .. "/local-plugin",
    },
    install = {
        colorscheme = {"kanagawa"},
    },
    ui = {
        border = "rounded",
        icons = {
            ft = "",
            loaded = "",
            not_loaded = "",
        },
    },
    checker = {
        enabled = true,
        concurrency = 10,
        notify = true,
        frequency = 7200,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "bugreport",
                "compiler",
                "ftplugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logiPat",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "netrwSettings",
                "optwin",
                "remote_plugins",
                "rplugin",
                "rrhelper",
                "shada_plugin",
                "spellfile_plugin",
                "syntax",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "tutor_mode_plugin",
                "vimball",
                "vimballPlugin",
                "zipPlugin",
            }
        }
    }
}
require("lazy").setup("plugins",settings)
