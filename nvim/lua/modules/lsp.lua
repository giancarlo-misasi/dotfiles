local M = {}

local servers_by_filetype = {
  c = { "clangd" },
  cpp = { "clangd" },
  -- rust-analyzer handled by rustaceanvim
  lua = { "lua_ls" },
  go = { "gopls" },
  python = { "pyright", "ruff" },
  java = { "jdtls" },
  markdown = { "marksman" },
  zig = { "zls" },
}

local excluded_servers = {
  rust = true,
}

local function find_workspace_folders(directory, filename)
  local results = {}
  local dir = vim.fs.find({ directory }, { upward = true, type = "directory" })[-2]
  if dir then
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

local function remove_all_workspace_folders()
  local workspace_folders = vim.lsp.buf.list_workspace_folders()
  for _, folder in ipairs(workspace_folders) do
    vim.lsp.buf.remove_workspace_folder()
  end
end

local function add_workspace_folders(folders)
  local folder_names = {}
  for _, f in ipairs(folders) do
    table.insert(folder_names, f:match("([^/]+)$"))
    vim.lsp.buf.add_workspace_folder(f)
  end
end

local function setup_rust()
  if not _G.rust_lsp_initialized then
    -- initialize rustaceanvim
    require("rustaceanvim")

    -- run once
    _G.rust_lsp_initialized = true
  end
end

local function setup_java()
  if not _G.java_lsp_initialized then
    local opts = {}

    -- add support for multiroot workspaces
    local ok, cfg = pcall(require, "config.java-multiroot")
    if ok then
      opts.root_markers = cfg.root_markers

      remove_all_workspace_folders()
      add_workspace_folders(find_workspace_folders(cfg.root_dir, cfg.folders_file))
    end

    -- initialize nvim-java
    require("java").setup(opts)

    -- run once
    _G.java_lsp_initialized = true
  end
end

local function start()
  if vim.bo.filetype == "rust" then
    setup_rust()
  elseif vim.bo.filetype == "java" then
    setup_java()
  end

  if not excluded_servers[vim.bo.filetype] then
    local servers = servers_by_filetype[vim.bo.filetype]
    if servers then
      vim.lsp.enable(servers_by_filetype[vim.bo.filetype], true)
    end
  end
end

local function stop()
  if not excluded_servers[vim.bo.filetype] then
    vim.lsp.enable(servers_by_filetype[vim.bo.filetype], false)
    vim.lsp.stop_client(vim.lsp.get_clients())
  end
end

M.is_running = function()
  return #vim.lsp.get_clients() > 0
end

M.toggle = function()
  require("mason-tool-installer") -- lazy load mason
  require("lspconfig")            -- use default lsp configs
  -- NOTE: lsp config overrides are in nvim/lsp/*

  if M.is_running() then
    stop()
  else
    start()
  end

  vim.cmd("edit") -- reload the buffer
end

return M
