local M = {}

M.start = function()
  -- debug target at current cursor position
  if #vim.lsp.get_clients() > 0 then
    vim.ui.select({
      "Debug",
      "Test",
    }, {
      prompt = "Select an action:"
    }, function(choice)
      if choice == "Debug" then
        vim.cmd("DapContinue")
      elseif choice == "Test" then
        vim.cmd("JavaTestDebugCurrentMethod")
      end
    end)
  end
end

return M
