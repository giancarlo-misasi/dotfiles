local name = 'options'
local utils = require('utils').start_script(name)

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
  clipboard = 'unnamed', -- combined with clipboard.lua to enable sync to wsl system clipboard
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

-- configure netrw to look like a file tree
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1

-- setup auto-complete options
vim.opt.pumheight = 6

-- disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

utils.end_script(name)
