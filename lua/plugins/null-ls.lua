return {
    -- 使用lua注入诊断、格式化、补全服务
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        event = {"BufReadPre","BufNewFile"},
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                lazy = true,
                cmd = {"NullLsInstall","NullLsUninstall"},
                dependencies = {"mason.nvim"},
                config =function ()
                    require("mason-null-ls").setup({
                        ensure_installed = {
                            "cmake_format","eslint_d","luacheck","markdownlint","ruff","shellcheck",
                            "jsonlint","yamllint","vint","cspell",
                            "prettier","stylua","yapf","shellharden","beautysh","jq"
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

            -- tsc,zsh,fish,tidy,stylelint,xq,taplo需要自行安装
            local sources = {
                -- Diagnostics
                diagnostics.cmake_lint, --cmake
                diagnostics.eslint_d, --javascript,javascriptact,typescript,typescriptact,vue
                diagnostics.tsc, -- javascript,typescript
                diagnostics.luacheck, --lua
                diagnostics.markdownlint, --markdown
                diagnostics.ruff, --python
                diagnostics.shellcheck, --sh
                diagnostics.zsh, --zsh
                diagnostics.fish, --fish
                diagnostics.tidy, --html,xml
                diagnostics.stylelint, -- css
                diagnostics.jsonlint, --json
                diagnostics.yamllint, --yaml
                diagnostics.vint, --vim
                diagnostics.cspell.with({
                    disabled_filetypes = {
                        "c","cpp","cmake","javascript","typescript","vue","lua","markdown","python",
                        "bash","sh","zsh","fish","html","xml","css","json","yaml","yml","vim","java","rust"
                    }
                }),
                -- Formatting
                formatting.cmake_format, --cmake
                formatting.prettier.with({ -- javascript,typescript,css,html,markdown,yaml,vue,jsx
                    disabled_filetypes = {"json"}
                }),
                formatting.stylua, --lua,luau
                formatting.yapf, --python
                formatting.shellharden, --sh,bash
                formatting.fish_indent, --fish
                formatting.beautysh.with({ --zsh
                    disabled_filetypes = {"sh","bash"}
                }),
                formatting.xq, --xml
                formatting.jq, --json
                formatting.taplo, --toml
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
        end,
        keys = {
            {"<leader>ni","<cmd>NullLsInfo<CR>",desc = "Show Null-ls Info"},
            {"<leader>nl","<cmd>NullLsLog<CR>",desc = "Show Null-ls Log"}
        }
    }
}