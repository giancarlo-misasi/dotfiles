local enable_ux_plugins = not vim.g.vscode
local dap = require("modules.dap")

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
  return require("modules.lsp").is_running()
end

local function show_debug_icons()
  return dap.is_running() or dap.is_ui_open()
end

local function is_debugging()
  return dap.is_running()
end

local function is_debug_ui_open()
  return dap.is_ui_open()
end

local function show_tabline()
  return has_tabs() or show_debug_icons()
end

local show_tabline_fix = {
  function()
    vim.opt.showtabline = show_tabline() and 2 or 0; return ""
  end
}

local colors = {
  white1 = "#DEEEED",
  green1 = "#243224",
  blue1 = "#242448",
  red1 = "#322424",
  red2 = "#482424"
}

local filename = {
  "filename",
  icon = "󰈢",
  on_click = function() vim.cmd("Buffers") end
}

local filetype = {
  "filetype",
  separator = { left = '' },
  on_click = function() vim.cmd("SetLanguage") end,
}

local fileformat = {
  "fileformat",
  separator = { left = '' },
}

local encoding = {
  "encoding",
  separator = { left = '', right = '' },
}

local tabs = {
  "tabs",
  cond = has_tabs,
}

local branch = {
  "branch",
  on_click = function() vim.cmd("Git") end,
}

local diagnostics = {
  "diagnostics",
  on_click = function() vim.cmd("Diagnostics") end,
}

local close_window = {
  function() return has_wins() and [[]] or [[]] end,
  on_click = function() vim.cmd("close") end,
  color = { bg = colors.red1, fg = colors.white1 },
}

local close_tab = {
  function() return has_tabs() and [[]] or [[]] end,
  on_click = function() vim.cmd("tabclose") end,
  color = { bg = colors.red2, fg = colors.white1 },
}

local debug_start = {
  function() return (show_debug_icons() and not is_debugging()) and [[  ]] or [[]] end,
  on_click = function() dap.start() end,
}

local debug_resume = {
  function() return (show_debug_icons() and is_debugging()) and [[  ]] or [[]] end,
  on_click = function() vim.cmd("DapContinue") end,
}

local debug_step_into = {
  function() return show_debug_icons() and [[ 󰆹 ]] or [[]] end,
  on_click = function() vim.cmd("DapStepInto") end,
}

local debug_step_out = {
  function() return show_debug_icons() and [[ 󰆸 ]] or [[]] end,
  on_click = function() vim.cmd("DapStepOut") end,
}

local debug_step_over = {
  function() return show_debug_icons() and [[ 󰆷  ]] or [[]] end,
  on_click = function() vim.cmd("DapStepOver") end,
}

local debug_stop = {
  function() return show_debug_icons() and [[  ]] or [[]] end,
  on_click = function() vim.cmd("DapTerminate") end,
}

local debug_ui_toggle = {
  function() return is_debug_ui_open() and [[  ]] or [[  ]] end,
  separator = { left = '' },
  color = function() return { bg = is_debug_ui_open() and colors.red1 or colors.blue1, fg = colors.white1 } end,
  on_click = function() require("modules.dap").toggle_ui() end,
}

local lsp_toggle = {
  function() return has_lsp() and [[  󱐋 ]] or [[  󱐋 ]] end,
  separator = { left = '' },
  color = function() return { bg = has_lsp() and colors.red1 or colors.green1, fg = colors.white1 } end,
  on_click = function() require("modules.lsp").toggle() end,
}

local lsp_status = {
  function() return package.loaded["lspconfig"] and require("lsp-progress").progress() or [[]] end,
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
    },
    init = function()
      local lualine = require("lualine")
      lualine.setup({
        options = {
          theme = "lackluster",
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        tabline = {
          lualine_a = { show_tabline_fix },
          lualine_x = {
            debug_start, debug_resume, debug_step_into, debug_step_out, debug_step_over, debug_stop,
          },
          lualine_y = { tabs },
          lualine_z = { close_tab },
        },
        winbar = {
          lualine_a = { filename },
          lualine_z = { close_window },
        },
        inactive_winbar = {
          lualine_a = { filename },
          lualine_z = { close_window },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { branch, diagnostics },
          lualine_c = { lsp_status },
          lualine_x = { debug_ui_toggle, filetype, lsp_toggle, encoding, fileformat },
          lualine_y = {},
          lualine_z = { "location" },
        },
      })
    end
  },
  {
    "luukvbaal/statuscol.nvim",
    cond = enable_ux_plugins,
    lazy = false,
    priority = 998,
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
  {
    "stevearc/oil.nvim",
    cond = enable_ux_plugins,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 997,
    config = function()
      require("oil").setup()
    end
  },
  {
    "rcarriga/nvim-notify",
    cond = enable_ux_plugins,
    lazy = false,
    config = function()
      vim.notify = require("notify")
    end
  },
  {
    "linrongbin16/lsp-progress.nvim",
    cond = enable_ux_plugins,
    lazy = true,
    config = function()
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
    end
  },
  {
    "dstein64/nvim-scrollview",
    cond = enable_ux_plugins,
    event = "VeryLazy",
    config = function()
      vim.g.scrollview_signs_max_per_row = 1
      vim.g.scrollview_cursor_symbol = ""
      vim.g.scrollview_diagnostics_hint_symbol = ""
      vim.g.scrollview_diagnostics_info_symbol = ""
      vim.g.scrollview_diagnostics_warn_symbol = ""
      vim.g.scrollview_diagnostics_errror_symbol = ""
      vim.g.scrollview_trail_symbol = ""
      require("scrollview").setup({
        signs_on_startup = {'cursor', 'search', 'diagnostics', 'trail'},
        diagnostics_severities = {
          vim.diagnostic.severity.HINT,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.ERROR,
        },
      })
    end
  },
  {
    "sphamba/smear-cursor.nvim",
    cond = enable_ux_plugins,
    event = "VeryLazy",
    opts = {
      cursor_color = "#00AA00",
    },
  },
  {
    "stevearc/dressing.nvim",
    cond = enable_ux_plugins,
    event = "VeryLazy",
  },
}
