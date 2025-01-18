local lc_dir = vim.fn.expand("~/.local/share/nvim/leetcode")
local lc_binaries = {}
local lc_cargo_toml_path = lc_dir .. "/Cargo.toml"
local cargo_toml_header = [[
[package]
name = "leetcode_binaries"
version = "0.1.0"
edition = "2021"

# Auto-generated binary entries
]]

local function generate_cargo_toml()
  local cargo_toml = io.open(lc_cargo_toml_path, "w")
  if not cargo_toml then
    error("Failed to open Cargo.toml for writing: " .. lc_cargo_toml_path)
  end

  -- Write the header
  cargo_toml:write(cargo_toml_header)

  -- Scan the source directory for .rs files
  local uv = vim.loop
  local handle = uv.fs_scandir(lc_dir)
  if not handle then
    error("Failed to scan directory: " .. lc_dir)
  end

  -- Write binary entries for each file
  while true do
    local name, type = uv.fs_scandir_next(handle)
    if not name then break end
    if type == "file" and name:match("%.rs$") then
      local bin_name = name:gsub("%.rs$", ""):gsub("%.", "_") -- Replace periods with underscores
      cargo_toml:write(string.format(
        "[[bin]]\nname = \"%s\"\npath = \"%s/%s\"\n\n",
        bin_name, lc_dir, name
      ))
    end
  end

  cargo_toml:close()
end

local function start_leet()
  require("leetcode")
  vim.cmd("bufdo bdelete")
  vim.cmd("Oil") -- workaround to satisfy no buffers constraint for leetcode plugin
  vim.cmd("Leet")
end

vim.api.nvim_create_user_command('StartLeet', start_leet, {})
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "rust" then
      local buf_path = vim.fn.expand("%:p")
      if buf_path:find(lc_dir, 1, true) then
        for _, value in ipairs(lc_binaries) do
          if value == buf_path then
            return
          end
        end
        generate_cargo_toml()
        table.insert(lc_binaries, buf_path)
      end
    end
  end,
})

return {
  {
    "kawre/leetcode.nvim",
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "rust",
    },
  },
}
