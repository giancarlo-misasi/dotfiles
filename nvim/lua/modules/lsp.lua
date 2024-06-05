local M = {}

M.setup = function(server_name)
    if server_name == "jdtls" then
        -- noop
    else
        -- otherwise, use default lsp-config setup behavior
        require("lspconfig")[server_name].setup({ autostart = false })
    end
end

M.start = function()
    local matching_configs = require('lspconfig.util').get_config_by_ft(vim.bo.filetype)
    for _, config in ipairs(matching_configs) do
        if config.name == 'jdtls' then
            -- use nvim-jdtls to start the server
            require("plugins.lsp.java").start()
        else
            -- otherwise, use default lsp-config start behavior
            vim.cmd("LspStart " .. config.name)
        end
    end
end

return M
