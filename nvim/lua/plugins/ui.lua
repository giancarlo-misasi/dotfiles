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

local filetype = {
    "filetype",
    on_click = function() vim.cmd("SetLanguage") end,
}

local diagnostics = {
    "diagnostics",
    on_click = function() vim.cmd("Diagnostics") end,
}

local close_window = {
    function() return has_wins() and [[]] or [[]] end,
    on_click = function() vim.cmd("close") end,
    color = { bg = "#191919", fg = "#AAAAAA" },
}

local close_tab = {
    function() return has_tabs() and [[ tab]] or [[]] end,
    on_click = function() vim.cmd("tabclose") end,
    color = { bg = "#AAAAAA", fg = "#191919" },
    cond = has_tabs,
}

local hide_tabs_fix = {
    function()
        vim.o.showtabline = has_tabs() and 1 or 0; return ""
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

local function get_relative_line_number()
    local current_line = vim.fn.line(".")
    local drawn_line = vim.v.lnum
    local relative_line = math.abs(drawn_line - current_line)
    local max_line = vim.fn.line("$")
    local max_digits = #tostring(max_line)
    local rel_str = tostring(relative_line)
    return string.rep(" ", max_digits - #rel_str) .. rel_str
end

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
                    lualine_a = { "mode" },
                    lualine_b = { "branch", diagnostics },
                    lualine_c = { lsp_status },
                    lualine_x = { "encoding", "fileformat", filetype, lsp_toggle },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
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
    {
        "luukvbaal/statuscol.nvim",
        cond = enable_ux_plugins,
        lazy = false,
        config = function()
            local statuscol = require("statuscol")
            local builtin = require("statuscol.builtin")
            statuscol.setup({
                segments = {
                    {
                        text = { " ", "%s", " " },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { builtin.lnumfunc, " ", function() return get_relative_line_number() end, " " },
                        click = "v:lua.ScLa", -- line number action (click = breakpoint, C-click = conditional breakpoint)
                    },
                    {
                        text = { builtin.foldfunc, " " },
                        click = "v:lua.ScFa" -- fold action
                    },
                }
            })
        end
    },
}
