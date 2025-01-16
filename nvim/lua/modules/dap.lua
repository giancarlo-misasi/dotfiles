local M = {}

M.start = function()
  -- load lazy plugins
  require("dap")

  -- load the language specific configuration and start
  require("plugins.dap.config." .. vim.bo.filetype).start()
end

M.is_running = function()
  if not package.loaded["dap"] then
    return false
  end
  local ok, dap = pcall(require, "dap")
  if not ok then
    return false
  end
  return dap.session() ~= nil
end

M.toggle_ui = function()
    require("dap")
    require("dapui").toggle()
end

M.is_ui_open = function()
  local dap_ui_windows = {
    "DAP Scopes",
    "DAP Breakpoints",
    "DAP Stacks",
    "DAP Watches",
    "DAP Console",
  }

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    for _, name in ipairs(dap_ui_windows) do
      if buf_name:match(vim.pesc(name)) then
        return true
      end
    end
  end
  return false
end

return M
