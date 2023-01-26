local name = 'clipboard'
local utils = require('utils').start_script(name)

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

-- https://mitchellt.com/2022/05/15/WSL-Neovim-Lua-and-the-Windows-Clipboard.html
-- wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
-- mv win32yank.exe /usr/local/bin/win32yank.exe && chmod +x /usr/local/bin/win32yank.exe
-- chmod +x nvim_paste && cp nvim_paste /usr/local/bin
if os.getenv('WSL_DISTRO_NAME') ~= nil then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
else
    vim.g.clipboard = {
      name = 'osc52',
      copy = { ['+'] = copy, ['*'] = copy },
      paste = { ['+'] = paste, ['*'] = paste },
      cache_enabled = true
    }
end

utils.end_script(name)
