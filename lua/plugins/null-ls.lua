return {
    -- 使用lua注入诊断、格式化、补全服务
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        event = {"BufReadPre","BufNewFile"},
        init = function ()
            vim.keymap.set("n","<leader>ni","<cmd>NullLsInfo<CR>",{desc = "Show Null-ls Info"})
            vim.keymap.set("n","<leader>nl","<cmd>NullLsLog<CR>",{desc = "Show Null-ls Log"})
        end,
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                cmd = {"NullLsInstall","NullLsUninstall"},
                dependencies = {"mason.nvim"},
                -- zsh,fish,tidy,xq,eslint需要自行安装
                -- 缘由：
                -- zsh,fish,tidy,xq,eslint:mason没有这些包
                config =function ()
                    require("mason-null-ls").setup({
                        ensure_installed = {
                            "cmake_format","luacheck","markdownlint","ruff","shellcheck","stylelint",
                            "jsonlint","yamllint","vint","cspell","editorconfig_checker",
                            "prettier","stylua","yapf","beautysh","jq"
                        },
                        automatic_installation = false,
                        automatic_setup = true
                    })
                end
            }
        },
        config = function()
            local null_ls = require("null-ls")
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting

            local sources = {
                -- Diagnostics
                diagnostics.cmake_lint, --cmake
                diagnostics.eslint, --javascript,javascriptact,typescript,typescriptact,vue
                diagnostics.luacheck, --lua
                diagnostics.markdownlint, --markdown
                diagnostics.ruff, --python
                diagnostics.shellcheck, --sh
                diagnostics.zsh, --zsh
                diagnostics.fish, --fish
                diagnostics.markuplint, --html
                diagnostics.tidy.with({
                    disabled_filetypes = {"html"}
                }), --xml
                diagnostics.stylelint, -- css
                diagnostics.jsonlint, --json
                diagnostics.yamllint, --yaml
                diagnostics.vint, --vim
                diagnostics.cspell.with({
                    disabled_filetypes = {
                        "c","cpp","cmake","javascript","typescript","vue","lua","markdown","python","go","toml",
                        "bash","sh","zsh","fish","html","xml","css","json","yaml","yml","vim","java","rust"
                    }
                }),
                diagnostics.editorconfig_checker.with({ -- 检测编辑文件
                    disabled_filetypes = {"c","cpp","txt","help","log"}
                }),
                -- Formatting
                formatting.cmake_format, --cmake
                formatting.prettier.with({ -- javascript,typescript,css,html,markdown,yaml,vue,jsx,toml
                    disabled_filetypes = {"json"},
                    extra_filetypes = {"toml"}
                }),
                formatting.stylua, --lua,luau
                formatting.yapf, --python
                formatting.fish_indent, --fish
                formatting.beautysh, -- zsh,sh,bash
                formatting.xq, --xml
                formatting.jq, --json
            }
            null_ls.setup({
                sources = sources,
                border = "rounded",
                debug = true,
                diagnostics_config = {
                    underline = true,
                    virtual_text = true,
                    signs = true,
                    update_in_insert = true,
                    severity_sort = true,
                },
                diagnostics_format = "[#{c}] #{m} (#{s})"
            })
        end
    }
}
