local enable_ux_plugins = not vim.g.vscode

local function get_relative_line_number()
    local current_line = vim.fn.line(".")
    local drawn_line = vim.v.lnum
    local relative_line = math.abs(drawn_line - current_line)
    local max_line = vim.fn.line("$")
    local max_digits = #tostring(max_line)
    local rel_str = tostring(relative_line)
    return string.rep(" ", max_digits - #rel_str) .. rel_str
end

local function has_tabs()
    return #vim.fn.gettabinfo() > 1
end

local function has_wins()
    return #vim.api.nvim_list_wins() > 1
end

local function has_lsp()
    return #vim.lsp.get_clients() > 0
end

local function is_debugging()
    local dap_present, dap = pcall(require, "dap")
    if not dap_present then
        return false
    end
    return dap.session() ~= nil
end

local function show_tabline()
    return has_tabs() or is_debugging()
end

local function show_in_tabline()
    return show_tabline()
end

local function show_in_bufferline()
    return not show_tabline()
end

local filename = {
    "filename",
    icon = "󰈢",
    on_click = function() vim.cmd("Buffers") end
}

local filetype = {
    "filetype",
    on_click = function() vim.cmd("SetLanguage") end,
}

local tabs = {
    "tabs",
    cond = has_tabs,
}

local diagnostics = {
    "diagnostics",
    on_click = function() vim.cmd("Diagnostics") end,
}

local show_tabline_fix = {
    function()
        vim.opt.showtabline = show_tabline() and 2 or 0; return ""
    end
}

local close_window = {
    function() return has_wins() and [[   ]] or [[]] end,
    on_click = function() vim.cmd("close") end,
    color = { bg = "#191919", fg = "#AAAAAA" },
}

local close_tab = {
    function() return has_tabs() and [[  󰭋 ]] or [[]] end,
    on_click = function() vim.cmd("tabclose") end,
    color = { bg = "#AAAAAA", fg = "#191919" },
}

local debug_start = {
    function() return not is_debugging() and [[  ]] or [[]] end,
    on_click = function() vim.cmd("DapContinue") end,
}

local debug_resume = {
    function() return is_debugging() and [[  ]] or [[]] end,
    on_click = function() vim.cmd("DapContinue") end,
}

local debug_step_into = {
    function() return is_debugging() and [[ 󰆹 ]] or [[]] end,
    on_click = function() vim.cmd("DapStepInto") end,
}

local debug_step_out = {
    function() return is_debugging() and [[ 󰆸 ]] or [[]] end,
    on_click = function() vim.cmd("DapStepOut") end,
}

local debug_step_over = {
    function() return is_debugging() and [[ 󰆷  ]] or [[]] end,
    on_click = function() vim.cmd("DapStepOver") end,
}

local debug_stop = {
    function() return is_debugging() and [[  ]] or [[]] end,
    on_click = function() vim.cmd("DapTerminate") end,
}

local actions = function(cond)
    return {
        function() return [[  ]] end,
        on_click = function() vim.cmd("Actions") end,
        cond = cond,
    }
end

local files = function(cond)
    return {
        function() return [[ 󰱼 ]] end,
        on_click = function() vim.cmd("FindFiles") end,
        cond = cond,
    }
end

local grep = function(cond)
    return {
        function() return [[ 󱩾 ]] end,
        on_click = function() vim.cmd("LiveGrep") end,
        cond = cond,
    }
end

local lsp_toggle = function(cond)
    return {
        function() return has_lsp() and [[  󱐋 ]] or [[  󱐋 ]] end,
        on_click = function() vim.cmd(has_lsp() and "LspStop" or "StartLsp") end,
        cond = cond,
    }
end

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
                tabline = {
                    lualine_a = { show_tabline_fix },
                    lualine_x = {
                        debug_start, debug_resume, debug_step_into, debug_step_out, debug_step_over, debug_stop,
                        actions(show_in_tabline), files(show_in_tabline), grep(show_in_tabline),
                    },
                    lualine_y = { tabs },
                    lualine_z = { close_tab },
                },
                winbar = {
                    lualine_a = { filename },
                    lualine_y = { actions(show_in_bufferline), files(show_in_bufferline), grep(show_in_bufferline) },
                    lualine_z = { close_window },
                },
                inactive_winbar = {
                    lualine_a = { filename },
                    lualine_z = { close_window },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", diagnostics },
                    lualine_c = { lsp_status },
                    lualine_x = { "encoding", "fileformat", filetype, lsp_toggle, debug_start },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })

            local lsp_progress = require("lsp-progress")
            lsp_progress.setup({
                format = function(client_messages)
                    local sign = " 󱐋"
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
                clickhandlers = {
                    DapStopped = function() vim.cmd("DapContinue") end
                },
                segments = {
                    {
                        text = { " ", "%s", " " },
                        click = "v:lua.ScSa", -- sign action
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
