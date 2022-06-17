local name = 'options'
local utils = require('utils').start_script(name)
local icons = require 'icons'

local options = {
  backup = false,
  writebackup = false,
  swapfile = false,
  undofile = true,
  termguicolors = true,
  signcolumn = 'yes',
  conceallevel = 0,
  wrap = false,
  cursorline = true,
  showmode = true,
  showcmd = true,
  number = true,
  relativenumber = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  hlsearch = true,
  inccommand = 'nosplit',
  clipboard = 'unnamed,unnamedplus',
  tabstop = 2,
  softtabstop = -1,
  shiftwidth = 0,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  completeopt = {'menu', 'menuone'}, -- autocomplete always select first item
  updatetime = 300, -- faster completion (4000ms default)
  mouse = 'a',
  mousemodel = 'popup',
  keymodel = 'startsel',
  backspace = 'indent,eol,start',
  whichwrap = 'b,s,<,>,[,]',
}

-- Set the options
for k, v in pairs(options) do
  local status, exception = pcall(function()
    vim.opt[k] = v
  end)

  if not status then
    print('failed to set opt ' .. k .. ': ' .. exception)
  end
end

local signs = {
  { name = "DiagnosticSignError", text = icons.sign_icons.Error },
  { name = "DiagnosticSignWarn", text = icons.sign_icons.Warn },
  { name = "DiagnosticSignHint", text = icons.sign_icons.Hint },
  { name = "DiagnosticSignInfo", text = icons.sign_icons.Info },
}

-- Set the signs
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    text = sign.text,
    numhl = ""
  })
end

-- Highlighting
vim.cmd [[
  set guicursor=n-v-c:block,i-ci-ve:ver30-Cursor/lCursor,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175
  hi CursorLine guibg=#363C46
]]

utils.end_script(name)
