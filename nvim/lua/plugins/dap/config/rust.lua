local M = {}

M.start = function()
  -- debug target at current cursor position
  if #vim.lsp.get_clients() > 0 then
    vim.cmd.RustLsp('debug')
  end
end

return M
