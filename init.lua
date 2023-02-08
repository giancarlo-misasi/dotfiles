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
  p('tpope', 'vim-repeat'),
  p('tpope', 'vim-sensible'),
  p('tpope', 'vim-surround'),
  p('numtostr', 'comment.nvim'),

  -- clipboard, cut and delete
  p('ojroques', 'nvim-osc52'),
  p('gbprod', 'cutlass.nvim'),

  -- theme
  p('olimorris', 'onedarkpro.nvim'),
  
  -- keymaps
  p('folke', 'which-key.nvim'),
  
  -- session management
  p('folke', 'persistence.nvim'),

  -- ux improvements
  p('nvim-lualine', 'lualine.nvim', { 'kyazdani42/nvim-web-devicons' }),
  p('lukas-reineke', 'indent-blankline.nvim'),
  p('vonheikemen', 'searchbox.nvim', { 'muniftanjim/nui.nvim' }),
  p('dstein64', 'nvim-scrollview'),
  p('stevearc', 'dressing.nvim'),
  p('folke', 'trouble.nvim', { 'kyazdani42/nvim-web-devicons' }),
  -- p('folke', 'noice.nvim', { 
  --   'nvim-lualine/lualine.nvim', --lualine must finish first to avoid cmdheight bug
  --   'muniftanjim/nui.nvim', 
  --   'rcarriga/nvim-notify',
  -- }),

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

  -- language servers
  p('vonheikemen', 'lsp-zero.nvim', {
      -- lsp support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- debugging
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      -- formatters and linters
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
      -- autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-buffer',
      -- 'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind.nvim',
      -- snippets
      'l3mon4d3/luasnip',
      'rafamadriz/friendly-snippets',
      -- auto-pairing brackets
      'windwp/nvim-autopairs',
      'kosayoda/nvim-lightbulb',
  }),

  -- Tree view for when I'm not familiar with a project
  p('nvim-neo-tree', 'neo-tree.nvim', {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'muniftanjim/nui.nvim'
  }),

  -- Colorizer for showing html color codes
  p('norcalli', 'nvim-colorizer.lua'),

  -- Terminal for nvim (for running commands and such)
  p('akinsho', 'toggleterm.nvim')
})

utils.end_script(name)
