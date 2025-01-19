local M = {}

local lsp_utils = require("modules.lsp")
local server_name = "jdtls"
local opts = {}

-- add support for multiroot workspaces
local ok, cfg = pcall(require, "plugins.lsp.java-multiroot")
if ok then
  local folders = lsp_utils.find_workspace_folders(cfg.root_dir, folders_file)
  lsp_utils.add_workspace_folders(folders)
  opts.root_markers = cfg.root_markers
end

-- initialize nvim-java
require("java").setup(opts)

-- run lsp server setup
lsp_utils.default_setup(server_name, {})

M.start = function()
  lsp_utils.default_start(server_name)
end

return M
