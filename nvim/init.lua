local km = require("modules.keymap")

local function setup_plugin_manager()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

local function setup_plugins()
  require("lazy").setup("plugins")
end

-- register configuration first
require("config.options")
require("config.autocmd")
require("config.rightclick")
km.setup_keymaps()

-- setup plugins
setup_plugin_manager()
setup_plugins()
km.setup_plugin_keymaps()

-- register these last to make sure they take precedence
require("config.commands")
