local config ={
    flags = {
        allow_incremental_sync = true
    },
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.stdpath("data") .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', vim.fn.stdpath("data") .. '/mason/packages/jdtls/config_linux',
        '-data',vim.fn.stdpath("data") .. "/workspace/jdtls-workspace" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    },
    root_dir = require("jdtls.setup").find_root({".git","mvnw",".gradlew"}),
    settings = {
        java = {
            signatureHelp = {
                enable = true
            },
            contenProvider = {
                preferred = "fernflower"
            },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.hamcrest.CoreMatchers.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                    'org.mockito.Mockito.*',
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            }
        }
    },
    init_options = {
        bundles = {}
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}
require("jdtls").start_or_attach(config)
