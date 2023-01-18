local name = 'init.lua'
local utils = require('utils').start_script(name)

-- Debugging setup scripts
utils.debugging_enabled = false

-- Global function to simplify safe loading plugins
function setup(module, opts)
  local ok, m = require('utils').pcall(module)
  if ok then
    m.setup(opts or {})
  end
  return m
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

-- Load plugins using lazy.nvim
setup('lazy', {
  -- Basic editing
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  { 'gbprod/substitute.nvim', config = true },
  { 'gbprod/cutlass.nvim', config = function() 
      setup('cutlass', { override_del = true })
    end
  },
  
  -- Telescope
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim', version = '0.1.1', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() 
      local telescope = require("telescope")
      local config = require("telescope.config")
      
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
      
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      
      -- Configure telescope
      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      -- Setup fzf
      telescope.load_extension('fzf')
    end
  },

  -- LSP
  { 'VonHeikemen/lsp-zero.nvim', dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }, config = function()
        local lsp = require('lsp-zero')
        lsp.preset('recommended')

        -- Intellij style completion
        local cmp = require('cmp')
        local cmp_mappings = lsp.defaults.cmp_mappings()
        cmp_mappings['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, {"i","s","c",})

        lsp.setup_nvim_cmp({
          mapping = cmp_mappings
        })

        -- Make sure languages are installed
        lsp.ensure_installed({
          'cmake', 'clangd',  -- c++
          'gopls',            -- go
          'jdtls',            -- java
          'sumneko_lua',      -- lua
          'marksman'          -- markdown
        })

        lsp.setup()
      end
    },
  
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },

  -- Trouble
  { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons', config = true },

  -- Twilight
  { 'folke/twilight.nvim', config = true },

  -- Dashboard
  { 'goolord/alpha-nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function()
    require 'dashboard'
    end
  },
})

-- Load general settings and keymaps after plugins
require 'options'
require 'commands'
require 'clipboard'
require 'keymaps'

utils.end_script(name)
