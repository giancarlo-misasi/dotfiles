local M = {}

-- setup adapter and configuration
require("dap-python").setup("python3")

M.start = function()
  -- debug target at current cursor position
  vim.ui.select({
    "Debug file",
    "Debug method",
  }, {
    prompt = "Select an action:"
  }, function(choice)
    if choice == "Debug file" then
      vim.cmd("DapContinue")
    elseif choice == "Debug method" then
      require("dap-python").test_method()
    end
  end)
end

return M
