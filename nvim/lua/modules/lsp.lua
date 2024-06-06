local M = {}


local servers = {
    clangd = { 'c', 'cpp' },    -- Supports C and C++
    gopls = { 'go' },           -- Supports Go
    rust_analyzer = { 'rust' }, -- Supports Rust
    jdtls = { 'java' },         -- Supports Java
    lua_ls = { 'lua' }          -- Supports Lua
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
