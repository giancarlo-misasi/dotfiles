local M = {}

local servers = {
    clangd = { 'c', 'cpp' },
    lua_ls = { 'lua' },
    rust_analyzer = { 'rust' },
    gopls = { 'go' },
    pyright = { 'py' },
    jdtls = { 'java' },
    marksman = { 'md' },
}

local function get_lsp_server_for_current_filetype()
    local filetype = vim.bo.filetype
    for server, filetypes in pairs(servers) do
        for _, ft in ipairs(filetypes) do
            if ft == filetype then
                return server
            end
        end
    end
    return nil
end

M.setup = function(server_name)
    if server_name == "jdtls" then
        -- noop
    else
        -- otherwise, use default lsp-config setup behavior
        require("lspconfig")[server_name].setup({ autostart = false })
    end
end

M.start = function()
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
