local M = {}

M.default_setup = function(server_name, opts)
  local lspconfig = require("lspconfig")
  local cmp = require('blink.cmp')
  opts = vim.tbl_deep_extend("force", {
    autostart = false,
    capabilities = cmp.get_lsp_capabilities(),
  }, opts or {})
  lspconfig[server_name].setup(opts)
end

M.default_start = function(server_name)
  vim.cmd("LspStart " .. server_name)
end

M.start = function()
  local ok, lsp = pcall(require, "plugins.lsp.config." .. vim.bo.filetype)
  if not ok then
    vim.notify("LSP server not configured for " .. vim.bo.filetype)
  else
    lsp.start()
  end
end

M.is_running = function()
  return #vim.lsp.get_clients() > 0
end

M.toggle = function()
  if M.is_running() then
    vim.cmd("LspStop ++force")
  else
    M.start()
  end
end

M.find_workspace_folders = function(directory, filename)
  local results = {}
  local dir = vim.fs.find({ directory }, { upward = true, type = "directory" })[1]
  if dir then
    vim.notify("Found workspace root: " .. dir)
    local file = io.open(dir .. "/" .. filename, "r")
    if file then
      for line in file:lines() do
        table.insert(results, line)
      end
      file:close()
    end
  end
  return results
end

M.add_workspace_folders = function(folders)
  local folder_names = {}
  for _, f in ipairs(folders) do
    table.insert(folder_names, f:match("([^/]+)$"))
    vim.lsp.buf.add_workspace_folder(f)
  end
  vim.notify("Added workspace folders: " .. vim.inspect(folder_names))
end

return M
