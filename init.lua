local name = 'init.lua'
local utils = require('utils').start_script(name)

-- Debugging setup scripts
utils.debugging_enabled = false

-- Load general settings and key mappings
require 'options'
require 'commands'
require 'keymaps'

-- Global function to run default setup after loading module
function s(module, opts)
  local ok, m = require('utils').pcall(module)
  if ok then
    m.setup(opts or {})
  end
end

-- Global function to run custom setup after loading module
function c(plugin_module, setup_module)
  local plugin_module_ok, m = require('utils').pcall(plugin_module)
  if not plugin_module_ok then
    return
  end

  local setup_module_ok, s = require('utils').pcall(setup_module)
  if setup_module_ok then
    s.setup(m)
  end
end

-- The list of plugins we will use
local function specify_plugins(use)
  -- Required libraries
  use 'wbthomason/packer.nvim'
  
  -- Basic editing
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use {'gbprod/cutlass.nvim', config = function() s('cutlass', { override_del = true }) end}
  use {'gbprod/substitute.nvim', config = function() s('substitute') end}
end

-- Load packer to allow the use of these plugins
local ok, packer = pcall(require, 'packer')
if ok then
  local packer_compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua'

  packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end
    }
  }

  packer.startup {
    specify_plugins, 
    config = { compile_path = packer_compile_path }
  }

  require 'packer_compiled'
end

utils.end_script(name)
