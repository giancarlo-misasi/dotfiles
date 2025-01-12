local keymaps = require("config.keymaps")

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

local function setup_nops(opts)
  for _, r in pairs(opts) do
    vim.keymap.set("n", r.lhs, r.rhs, { silent = true, noremap = true, desc = "nop" })
  end
end

local function setup_keymaps(opts)
  for _, k in pairs(opts) do
    vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, silent = true, noremap = true })
  end
end

local function setup_lsp_keymaps(opts)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
    callback = function(event)
      for _, k in pairs(opts) do
        vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = event.buf })
      end
    end,
  })
end

require("config.options")
require("config.commands")
require("config.rightclick")
setup_plugin_manager()
setup_nops(keymaps.nops)
setup_keymaps(keymaps.editing)
setup_lsp_keymaps(keymaps.lsp)
setup_plugins()

