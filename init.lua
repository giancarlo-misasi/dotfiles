local name = 'init.lua'
local utils = require('utils').start_script(name)

-- Debugging setup scripts
utils.debugging_enabled = true

-- s = Setup
-- Requires the module and if successful, calls setup with opts
function s(module, opts)
  local ok, m = require('utils').pcall(module)
  if ok then
    m.setup(opts or {})
  end
  return m
end

-- r = Require only
-- Returns a function that when run will require a module for setup_ scripts
function r(module)
  return function() require('utils').pcall(module) end
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
local k = require 'keymaps'

-- Initialize basic keymaps and leader key
k.set_leader()
k.set_keymaps(k.basic_keymaps)

-- Load plugins using lazy.nvim
s('lazy', {
  -- Basic editing
  'tpope/vim-repeat',
  'tpope/vim-sensible',
  'tpope/vim-surround',
  { 'gbprod/cutlass.nvim', config = r('setup_cutlass') }, -- change deletes to not affect clipboard
  { 'numToStr/Comment.nvim', config = r('setup_comment') },

  -- Theme
  { 'navarasu/onedark.nvim', config = r('setup_onedark'),
      dependencies = {
        'kyazdani42/nvim-web-devicons'
      },
  },

  -- Landing page
  { 'goolord/alpha-nvim', config = r('setup_alpha'),
      dependencies = { 
        'kyazdani42/nvim-web-devicons'
      },
  },

  -- Tabs
  {'romgrk/barbar.nvim', config = r('setup_barbar'),
      dependencies = {
        'kyazdani42/nvim-web-devicons'
      },
  },

  -- Status line
  { 'nvim-lualine/lualine.nvim', config = r('setup_lualine'),
      dependencies = {
        'kyazdani42/nvim-web-devicons'
      },
  },

  -- Diagnostics and references
  { 'folke/trouble.nvim', config = r('setup_trouble'),
      dependencies = {
        'kyazdani42/nvim-web-devicons'
      },
  },

  -- File serch
  { 'nvim-telescope/telescope-fzf-native.nvim', config = r('setup_telescope'), build = 'make',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
  },

  -- Language servers
  { 'VonHeikemen/lsp-zero.nvim', config = r('setup_lsp'), branch = 'v1.x',
      dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Formatters and linters
        "jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
      },
  },
  
  -- Syntax tree for fast non lsp language features
  -- NOTE: Replaces need for 'vim-scripts/argtextobj.vim'
  { 'nvim-treesitter/nvim-treesitter', config = r('setup_treesitter'), build = ":TSUpdate",
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
  },

  -- Indent guides
  { 'lukas-reineke/indent-blankline.nvim', config = r('setup_indent_blankline'),
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
  },

    -- Auto pairing brackets
  { 'windwp/nvim-autopairs', config = r('setup_autopairs'),
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'hrsh7th/nvim-cmp',
      },
  },
})

utils.end_script(name)
