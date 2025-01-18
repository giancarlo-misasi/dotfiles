local keys = require("config.keymaps").textobjects_move_repeat
local rm = require("nvim-treesitter.textobjects.repeatable_move")
local map = vim.keymap.set
local nxo = { 'n', 'x', 'o' }
local df = "]"
local db = "["

if not unpack then
  unpack = table.unpack
end

local function repeatably_do(func, opts, additional_args)
  opts = opts or {}
  additional_args = additional_args or {}
  rm.last_move = {
    func = func,
    opts = opts,
    additional_args = additional_args,
  }
  func(opts, unpack(additional_args))
end

local function center(func)
  return function()
    func()
    vim.cmd('normal! zz')
  end
end

local function search(opts)
  return function()
    repeatably_do(function(o)
      o = o or {}
      if o.forward then
        vim.cmd('normal! n')
      else
        vim.cmd('normal! N')
      end
    end, opts)
  end
end

local function diagnostic_jump(opts)
  return function()
    repeatably_do(function(o)
      o = o or {}

      local count = o.forward and 1 or -1
      o.count = count * vim.v.count1

      if vim.diagnostic.jump then
        vim.diagnostic.jump(o)
      else
        -- Deprecated in favor of `vim.diagnostic.jump` in Neovim 0.11.0
        if o.count > 0 then
          vim.diagnostic.goto_next(o)
        else
          vim.diagnostic.goto_prev(o)
        end
      end
    end, opts)
  end
end

local function map_diagnostic(key, severity)
  local desc = string.lower(severity or 'diagnostic')
  map(nxo, df .. key, center(diagnostic_jump({ forward = true, severity = severity })), { desc = 'next ' .. desc })
  map(nxo, db .. key, center(diagnostic_jump({ forward = false, severity = severity })), { desc = 'previous ' .. desc })
end

-- set repeat keys
map(nxo, ";", center(rm.repeat_last_move_next), { desc = "repeat forward" })
map(nxo, ",", center(rm.repeat_last_move_previous), { desc = "repeat back" })

-- make f, F, t, T repeatable
map(nxo, "f", center(rm.builtin_f))
map(nxo, "F", center(rm.builtin_F))
map(nxo, "t", center(rm.builtin_t))
map(nxo, "T", center(rm.builtin_T))

-- make diagnostics repeatable
map_diagnostic(keys.diagnostic, nil)
map_diagnostic(keys.error, 'ERROR')
map_diagnostic(keys.warn, 'WARN')
map_diagnostic(keys.info, 'INFO')
map_diagnostic(keys.hint, 'HINT')

-- make search repeatable
vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = { "/", "?" },
  callback = function()
    local opts = { forward = true }
    rm.set_last_move(center(search(opts)), opts)
  end
})

