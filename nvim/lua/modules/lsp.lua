local M = {}
local tools = require("modules.tools")

local function default_lsp_setup(server_name)
    require("lspconfig")[server_name].setup({ autostart = false })
end

M.setup_lsp = function()
    default_lsp_setup("clangd")
    -- rust_analyzer is configured by rustaceanvim
    default_lsp_setup("lua-language-server")
    default_lsp_setup("gopls")
    default_lsp_setup("pyright")
    -- jdtls configured by nvim-jdtls
    default_lsp_setup("marksman")
end

M.start_lsp = function()
    local server_name = get_lsp_server_for_current_filetype()
    if server_name == 'jdtls' then
        -- use nvim-jdtls to start the server
        require("plugins.lsp.config.java").start()
    else
        -- otherwise, use default lsp-config start behavior
        vim.cmd("LspStart " .. server_name)
    end
end

return M
