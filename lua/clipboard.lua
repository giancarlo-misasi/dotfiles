local name = 'clipboard'
local utils = require('utils').start_script(name)

if os.getenv('WSL_DISTRO_NAME') ~= nil then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end

utils.end_script(name)
