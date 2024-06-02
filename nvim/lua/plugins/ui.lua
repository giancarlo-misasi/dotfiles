local enable_ux_plugins = not vim.g.vscode

local function has_tabs()
    return #vim.fn.gettabinfo() > 1
end

local function has_wins()
    return #vim.api.nvim_list_wins() > 1
end

local function has_lsp()
    return #vim.lsp.get_clients() > 0
end

local filename = {
    "filename",
    on_click = function() vim.cmd("Buffers") end
}

local close_window = {
    function() return has_wins() and [[]] or [[]] end,
    on_click = function() vim.cmd("close") end,
    color = { bg = '#191919', fg = '#AAAAAA' },
}

local close_tab = {
    function() return has_tabs() and [[ tab]] or [[]] end,
    on_click = function() vim.cmd("tabclose") end,
    color = { bg = '#AAAAAA', fg = '#191919' },
    cond = has_tabs,
}

local hide_tabs_fix = {
    function()
        vim.o.showtabline = has_tabs() and 1 or 0; return ''
    end
}

local lsp_toggle = {
    function() return has_lsp() and [[ lsp]] or [[ lsp]] end,
    on_click = function() vim.cmd(has_lsp() and "LspStop" or "LspStart") end
}

local lsp_status = {
    function() return require("lsp-progress").progress() end,
    on_click = function() vim.cmd("LspInfo") end
}

return {
    {
        "slugbyte/lackluster.nvim",
        cond = enable_ux_plugins,
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("lackluster-mint")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        cond = enable_ux_plugins,
        lazy = false,
        priority = 999,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "linrongbin16/lsp-progress.nvim",
        },
        init = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    theme = "lackluster",
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { lsp_status },
                    lualine_x = { 'encoding', 'fileformat', 'filetype', lsp_toggle },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                winbar = {
                    lualine_a = { filename },
                    lualine_z = { close_window },
                },
                inactive_winbar = {
                    lualine_a = { filename },
                    lualine_z = { close_window },
                },
                tabline = {
                    lualine_y = { { "tabs", cond = has_tabs }, hide_tabs_fix },
                    lualine_z = { close_tab }
                },
            })

            local lsp_progress = require("lsp-progress")
            lsp_progress.setup({
                format = function(client_messages)
                    local sign = " lsp" -- icon: nf-cod-info
                    if #client_messages > 0 then
                        return " " .. table.concat(client_messages, " ")
                    end
                    if has_lsp() then
                        return sign
                    end
                    return ""
                end,
            })

            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end
    },
    {
        "dstein64/nvim-scrollview",
        cond = enable_ux_plugins,
        event = "VeryLazy",
    },
}
