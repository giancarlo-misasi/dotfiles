return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui"
    },
    lazy = true,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      -- dont open by default as we dont always need it
      -- dap.listeners.before.attach.dapui_config = function() dapui.open() end
      -- dap.listeners.before.launch.dapui_config = function() dapui.open() end
    end
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
  },
  {
    "tomblind/local-lua-debugger-vscode",
    lazy = true,
    build = function()
      local path = vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode"
      vim.fn.system("cd " .. path .. " && npm install && npm run build")
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
  },
}
