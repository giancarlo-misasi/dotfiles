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

local function count_visible_panes()
  local windows = vim.api.nvim_list_wins()
  local visible_panes = 0
  for _, win in ipairs(windows) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative == "" then
      visible_panes = visible_panes + 1
    end
  end
  return visible_panes
end

local function has_wins()
  return count_visible_panes() > 1
end

local function has_lsp()
  return require("modules.lsp").is_running()
end

local function show_tabline()
  return false
end

local show_tabline_fix = {
  function()
    vim.opt.showtabline = show_tabline() and 2 or 0; return ""
  end
}

local colors = {
  white1 = "#DEEEED",
  green1 = "#506070",
  red1 = "#444444",
}

local filename = {
  "filename",
  icon = "󰈢",
  on_click = function() vim.cmd("FileTree") end
}

local filetype = {
  "filetype",
  separator = { left = '' },
}

-- local fileformat = {
--   "fileformat",
--   separator = { left = '' },
-- }
--
-- local encoding = {
--   "encoding",
--   separator = { left = '', right = '' },
-- }

local tabs_icon = {
  function() return [[  ]] end,
  cond = has_tabs,
}

local tabs = {
  "tabs",
  tabs_color = {
    active = { bg = '#242424', fg = '#DEEEED' },
    inactive = { bg = '#242424', fg = '#888888' },
  },
  cond = has_tabs,
}

-- local branch = {
--   "branch",
--   color = { bg = colors.yellow1, fg = colors.white1 },
--   separator = { right = '' },
-- }

local diagnostics = {
  "diagnostics",
  on_click = function() vim.cmd("Diagnostics") end,
}

local split_right = {
  function() return [[]] end,
  on_click = function() vim.cmd("vsplit") end,
  separator = {},
}

local split_down = {
  function() return [[]] end,
  on_click = function() vim.cmd("split") end,
  separator = {},
}

local close_window = {
  function() return has_wins() and [[]] or [[]] end,
  on_click = function() vim.cmd("close") end,
  color = { bg = colors.red1, fg = colors.white1 },
}

local lsp_toggle = {
  function() return has_lsp() and [[  󱐋 ]] or [[  󱐋 ]] end,
  separator = { left = '' },
  color = function() return { bg = has_lsp() and colors.red1 or colors.green1, fg = colors.white1 } end,
  on_click = function() require("modules.lsp").toggle() end,
}

local lsp_status = {
  function() return package.loaded["lspconfig"] and [[  󱐋 ]] or [[]] end,
  on_click = function() vim.cmd("vertical checkhealth vim.lsp") end,
}

return {
  {
    "slugbyte/lackluster.nvim",
    cond = enable_ux_plugins,
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("lackluster-mint")
      vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#FF69B4', bg = 'none' })
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
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        tabline = {
          lualine_a = { show_tabline_fix },
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {
          lualine_a = { filename },
          lualine_y = { split_right, split_down },
          lualine_z = { close_window },
        },
        inactive_winbar = {
          lualine_a = { filename },
          lualine_z = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { diagnostics, lsp_status },
          lualine_c = { tabs_icon, tabs, },
          lualine_x = { filetype, lsp_toggle },
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
    opts = {
      cleanup_delay_ms = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    cond = enable_ux_plugins,
    lazy = false,
    opts = {
      timeout = 100,
      max_width = 40,
    }
  },
  {
    "folke/noice.nvim",
    cond = enable_ux_plugins,
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
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
    "NStefan002/screenkey.nvim",
    cond = enable_ux_plugins,
    lazy = false,
    version = "*",
  },
}
