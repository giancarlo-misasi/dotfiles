return {
	{
		"ojroques/nvim-osc52",
		lazy = false,
        init = function()
            local copy = {
                osc52 = function(lines, _)
                    require("osc52").copy(table.concat(lines, "\n"))
                end,
                wsl = "clip.exe",
            }
        
            local paste = {
                osc52 = function()
                    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
                end,
                wsl = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            }
        
            local clipboards = {
                osc52 = {
                    name = "osc52",
                    copy = { ["+"] = copy.osc52, ["*"] = copy.osc52 },
                    paste = { ["+"] = paste.osc52, ["*"] = paste.osc52 },
                    cache_enabled = true,
                },
                wsl = {
                    name = "wsl",
                    copy = { ["+"] = copy.wsl, ["*"] = copy.wsl },
                    paste = { ["+"] = paste.wsl, ["*"] = paste.wsl },
                    cache_enabled = false,
                },
            }
        
            if vim.fn.has("wsl") == 1 then
                vim.g.clipboard = clipboards.wsl
            else
                vim.g.clipboard = clipboards.osc52
            end
        end
	},
}
