local dap = require("dap")
local extension_path = vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/"

dap.adapters.luadb = {
  type = "executable",
  command = "node",
  args = { extension_path .. "extension/debugAdapter.js" },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = extension_path
      on_config(c)
    else
      on_config(config)
    end
  end,
}
