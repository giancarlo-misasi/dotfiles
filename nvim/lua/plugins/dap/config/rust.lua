local M = {}

-- setup adapter and configuration
-- handled automatically by rustaceanvim
-- start the lsp if its not running to enable dap
if #vim.lsp.get_clients() == 0 then
    require("modules.lsp").start()
end

M.start = function()
    -- debug target at current cursor position
    if #vim.lsp.get_clients() > 0 then
        vim.cmd.RustLsp('debug')
    end
end

return M
