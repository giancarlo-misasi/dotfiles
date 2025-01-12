local dap = require("dap")
local mason_path = require("mason-core.path").package_prefix()

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  host = "127.0.0.1",
  executable = {
    command = mason_path .. "/codelldb/extension/adapter/codelldb",
    args = {
      "--liblldb", mason_path .. "/codelldb/extension/lldb/lib/liblldb.so",
      "--port", "${port}"
    },
  },
}
