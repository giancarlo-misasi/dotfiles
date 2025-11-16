local globals = {
  mapleader = " ",
  maplocalleader = " ",
  loaded_python3_provider = 0,
  loaded_ruby_provider = 0,
  loaded_perl_provider = 0,
  loaded_node_provider = 0,
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  loaded_matchit = 1, -- turn off matchit extensions
}

local options = {
  clipboard = "unnamedplus",
  writebackup = false,
  swapfile = false,
  undofile = true,
  number = true,
  relativenumber = false, -- using statuscol to show both
  wrap = false,
  cursorline = true,
  termguicolors = true,
  signcolumn = "yes",
  showmode = true,
  showcmd = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  hlsearch = true,
  inccommand = "nosplit",
  tabstop = 2,
  softtabstop = -1,
  shiftwidth = 0,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  mouse = "a",
  mousemodel = "popup",
  keymodel = "startsel",
  backspace = "indent,eol,start",
  whichwrap = "b,s,<,>,[,]",
  completeopt = { "fuzzy", "menu", "menuone", "noinsert" }, -- autocomplete always select first item
  updatetime = 300,                                         -- faster completion (4000ms default)
  pumheight = 6,
  fillchars = {
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    foldopen = "",
    foldsep = "┃",
    foldclose = "",
  },
  foldlevel = 99,
  foldcolumn = "1",
  timeoutlen = 1000, --350, -- don't wait as long for key combos (cs vs c then s)
}

local function setup_globals(opts)
  for k, v in pairs(opts) do
    local status, exception = pcall(function()
      vim.g[k] = v
    end)
    if not status then
      print("failed to set global " .. k .. ": " .. exception)
    end
  end
end

local function setup_options(opts)
  for k, v in pairs(opts) do
    local status, exception = pcall(function()
      vim.opt[k] = v
    end)
    if not status then
      print("failed to set opt " .. k .. ": " .. exception)
    end
  end
end

local function setup_diagnostics()
  vim.diagnostic.config({
    virtual_text = true,
    -- virtual_lines = true,
    signs = {
      enable = true,
      text = {
        ["ERROR"] = " ",
        ["WARN"]  = " ",
        ["HINT"]  = " ",
        ["INFO"]  = " ",
      },
      texthl = {
        ["ERROR"] = "DiagnosticDefault",
        ["WARN"] = "DiagnosticDefault",
        ["HINT"] = "DiagnosticDefault",
        ["INFO"] = "DiagnosticDefault",
      },
      numhl = {
        ["ERROR"] = "DiagnosticDefault",
        ["WARN"] = "DiagnosticDefault",
        ["HINT"] = "DiagnosticDefault",
        ["INFO"] = "DiagnosticDefault",
      },
      severity_sort = true,
    },
  })
end

local function setup_clipboard()
  -- Force OSC52 for copy operations
  -- Use default for paste given paste support doesn't always work
  vim.g.clipboard = {
    name = 'OSC52 Copy + Default Paste',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = function()
        return vim.fn.getreg("+", 1, true)
      end,
      ['*'] = function()
        return vim.fn.getreg("*", 1, true)
      end,
    },
  }
end

setup_globals(globals)
setup_options(options)
setup_diagnostics()
setup_clipboard()
