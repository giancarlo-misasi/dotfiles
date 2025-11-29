local M = {}
local keymaps = require("config.keymaps")
local map = vim.keymap.set
local nxo = { "n", "x", "o" }

if not unpack then
  unpack = table.unpack
end

local function with_center(func, ...)
  local success, _ = pcall(func, ...)
  if success then
    pcall(vim.cmd, "normal! zz")
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

local function jump(opts)
  return function()
    repeatably_do(function(o)
      o = o or {}
      if o.forward then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><C-i>", true, false, true), "n", true)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><C-o>", true, false, true), "n", true)
      end
    end, opts)
  end
end

local function search(opts)
  return function()
    repeatably_do(function(o)
      o = o or {}
      if o.forward then
        pcall(vim.cmd, 'normal! n')
      else
        pcall(vim.cmd, 'normal! N')
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

  -- make jump list repeatable
  map(nxo, opts.jump_list_forward, jump({ forward = true }))
  map(nxo, opts.jump_list_backward, jump({ forward = false }))

  -- make f, F, t, T repeatable
  map(nxo, "f", rm.builtin_f_expr, { expr = true })
  map(nxo, "F", rm.builtin_F_expr, { expr = true })
  map(nxo, "t", rm.builtin_t_expr, { expr = true })
  map(nxo, "T", rm.builtin_T_expr, { expr = true })

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
  map(nxo, opts.repeat_forward, rm.repeat_last_move_next, { desc = "repeat forward" })
  map(nxo, opts.repeat_backward, rm.repeat_last_move_previous, { desc = "repeat back" })
end

M.setup_keymaps = function()
  setup_nops(keymaps.nops)
  setup_keymaps(keymaps.editing)
end

M.setup_plugin_keymaps = function()
  setup_reatable_keymaps(keymaps.repeat_move)
end

return M
