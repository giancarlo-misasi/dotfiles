local M = {}
local keymaps = require("config.keymaps")
local map = vim.keymap.set
local nxo = { 'n', 'x', 'o' }

if not unpack then
  unpack = table.unpack
end

local function with_center(func, ...)
  local success, _ = pcall(func, ...)
  if success then
    vim.cmd('normal! zz')
  end
end

local function with_center_func(func)
  return function()
    with_center(func)
  end
end

local function repeatably_do(func, opts, additional_args)
  local rm = require("nvim-treesitter.textobjects.repeatable_move")
  opts = opts or {}
  additional_args = additional_args or {}
  rm.last_move = {
    func = func,
    opts = opts,
    additional_args = additional_args,
  }
  with_center(func, opts, unpack(additional_args))
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
      vim.diagnostic.jump(o)
    end, opts)
  end
end

local function setup_nops(opts)
  for _, r in pairs(opts) do
    map("n", r.lhs, r.rhs, { silent = true, noremap = true, desc = "nop" })
  end
end

local function setup_keymaps(opts)
  for _, k in pairs(opts) do
    map(k.mode, k.lhs, k.rhs, { desc = k.desc, silent = true, noremap = true })
  end
end

local function setup_reatable_keymaps(opts)
  local rm = require("nvim-treesitter.textobjects.repeatable_move")

  -- make f, F, t, T repeatable
  map(nxo, "f", with_center_func(rm.builtin_f))
  map(nxo, "F", with_center_func(rm.builtin_F))
  map(nxo, "t", with_center_func(rm.builtin_t))
  map(nxo, "T", with_center_func(rm.builtin_T))

  -- make search repeatable
  vim.api.nvim_create_autocmd("CmdlineLeave", {
    pattern = { "/", "?" },
    callback = function()
      local o = { forward = true }
      rm.set_last_move(search(o), o)
    end
  })

  -- diagnostics
  for _, k in pairs(opts.diagnostic_keys) do
    local desc = string.lower(k.severity or 'diagnostic')
    map(
      nxo,
      opts.move_forward .. k.key,
      diagnostic_jump({ forward = true, severity = k.severity }),
      { desc = 'next ' .. desc }
    )
    map(
      nxo,
      opts.move_backward .. k.key,
      diagnostic_jump({ forward = false, severity = k.severity }),
      { desc = 'previous ' .. desc }
    )
  end

  -- set repeat keys
  map(nxo, opts.repeat_forward, with_center_func(rm.repeat_last_move_next), { desc = "repeat forward" })
  map(nxo, opts.repeat_backward, with_center_func(rm.repeat_last_move_previous), { desc = "repeat back" })
end

M.setup_keymaps = function()
  setup_nops(keymaps.nops)
  setup_keymaps(keymaps.editing)
end

M.setup_plugin_keymaps = function()
  setup_reatable_keymaps(keymaps.repeat_move)
end

return M
