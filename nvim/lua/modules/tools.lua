local M = {}

local lsp_servers_by_filetype = {
    c = { "clangd" },
    cpp = { "clangd" },
    rust = { "rust_analyzer" },
    lua = { "lua_ls" },
    go = { "gopls" },
    python = { "pyright", "ruff" },
    java = { "jdtls" },
    markdown = { "marksman" },
}

local function get_lsp_servers_for_current_filetype()
    local filetype = vim.bo.filetype
    for ft, servers in pairs(lsp_servers_by_filetype) do
        if ft == filetype then
            return servers
        end
    end
    return nil
end

M.tools = {
    "clangd",
    "rust_analyzer",
    "codelldb",
    "lua_ls",
    "gopls",
    "pyright",
    "jdtls",
    "java-test",
    "java-debug-adapter",
    "marksman",
}

M.setup_lsp = function()
    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({ autostart = false })
    -- rust_analyzer is configured by rustaceanvim

    lspconfig.lua_ls.setup({
        autostart = false,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
    })

    lspconfig.gopls.setup({ autostart = false })

    lspconfig.pyright.setup({ autostart = false })
    lspconfig.ruff.setup({ autostart = false })

    -- jdtls configured by nvim-jdtls
    lspconfig.marksman.setup({ autostart = false })
end

M.start_lsp = function()
    local server_names = get_lsp_servers_for_current_filetype() or {}
    for _, server_name in pairs(server_names) do
        if server_name == 'jdtls' then
            -- use nvim-jdtls to start the server
            require("plugins.lsp.config.java").start()
        else
            -- otherwise, use default lsp-config start behavior
            vim.cmd("LspStart " .. server_name)
        end
    end
end

-- TODO: Formatters, linters etc
-- NOTE: Debuggers are handled by plugins/dap

return M
