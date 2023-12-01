local name = 'init.lua'
local utils = require('utils').start_script(name)

-- Debugging setup scripts
utils.debugging_enabled = false

-- Requires the module and if successful, calls setup with opts
function setup(module, opts)
  local ok, m = require('utils').pcall(module)
  if ok then
    m.setup(opts or {})
  end
  return m
end

-- How to declare a plugin
function p(repoOwner, repoName, dependencies, build)
  local src = repoOwner .. '/' .. repoName
  local plugin = string.gsub(string.gsub(repoName, ".nvim", ""), ".lua", "")
  local config = function()
    require('utils').pcall('setup_' .. plugin)
  end
  return { src, config = config, dependencies = dependencies, build = build }
end

-- Bootstrap lazy.nvim
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    path,
  })
end
vim.opt.rtp:prepend(path)

-- Load general settings and keymaps
require 'options'
require 'commands'
require 'clipboard'
require 'keymaps'

-- Load plugins using lazy.nvim
setup('lazy', {
  -- basic editing
  p('tpope', 'vim-surround'),
  p('numtostr', 'comment.nvim'),
  p('ojroques', 'nvim-osc52'),
  p('gbprod', 'cutlass.nvim'),

  -- theme
  { 'olimorris/onedarkpro.nvim', priority = 1000, config = function() require('setup_theme') end },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', config = function() require('setup_indent-blankline') end },

  -- ux improvements
  p('nvim-lualine', 'lualine.nvim', { 'kyazdani42/nvim-web-devicons' }),
  p('vonheikemen', 'searchbox.nvim', { 'muniftanjim/nui.nvim' }),
  p('dstein64', 'nvim-scrollview'),
  p('stevearc', 'dressing.nvim'),
  
  -- search and selection
  p('nvim-telescope', 'telescope-fzf-native.nvim', {}, 'make'),
  p('nvim-telescope', 'telescope.nvim', { 
    'nvim-lua/plenary.nvim', 
    'nvim-telescope/telescope-fzf-native.nvim', 
    'octarect/telescope-menu.nvim',
  }),

  -- syntax tree for fast non lsp language features
  -- note: replaces need for 'vim-scripts/argtextobj.vim'
  p('nvim-treesitter', 'nvim-treesitter', { 'nvim-treesitter/nvim-treesitter-textobjects' }, ':TSUpdate'),
})

utils.end_script(name)
