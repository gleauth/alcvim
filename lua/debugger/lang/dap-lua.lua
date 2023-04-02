local dap = require"dap"
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
    }
}
dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host, port = config.port })
end
