local enable_ux_plugins = not vim.g.vscode

local function has_tabs()
  return #vim.fn.gettabinfo() > 1
end

local function has_lsp()
  return require("modules.lsp").is_running()
end

local filename = {
  "filename",
  icon = "󰈢",
  on_click = function() vim.cmd("FileTree") end
}

local tabs = {
  "tabs",
  cond = has_tabs,
}

local diagnostics = {
  "diagnostics",
  on_click = function() vim.cmd("Diagnostics") end,
}

local lsp_toggle = {
  function() return has_lsp() and [[  󱐋 ]] or [[  󱐋 ]] end,
  on_click = function() require("modules.lsp").toggle() end,
}

local lsp_status = {
  function() return package.loaded["lspconfig"] and [[  󱐋 ]] or [[]] end,
  on_click = function() vim.cmd("vertical checkhealth vim.lsp") end,
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "frappe",
      auto_integrations = true,
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
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
          globalstatus = true,
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        winbar = {
          lualine_a = { filename },
        },
        inactive_winbar = {
          lualine_a = { filename },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", diagnostics, lsp_status },
          lualine_c = { tabs, },
          lualine_x = {},
          lualine_y = { lsp_toggle },
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
        segments = {
          {
            text = { " ", "%s", " " },
            click = "v:lua.ScSa", -- diagnostic / signs
          },
          {
            text = { builtin.lnumfunc, " ", " " },
            click = "v:lua.ScLa", -- line number
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
