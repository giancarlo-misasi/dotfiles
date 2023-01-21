local name = 'keymaps'
local utils = require('utils').start_script(name)
local M = {}

M.set_leader = function()
  vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {})
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
end

M.set_keymaps = function(keymap_pairs)
  for _, k in pairs(keymap_pairs) do
    if not k.buf then
      vim.keymap.set(k.mode, k.lhs, k.rhs, { silent = true, noremap = true })
    end
  end
end

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = v
--   visual_block_mode = x
--   term_mode = t
--   command_mode = c

M.basic_keymaps = {
  { name = 'copy',            mode = 'v', lhs = '<C-c>',      rhs = '"+y' },
  { name = 'cut',             mode = 'v', lhs = '<C-x>',      rhs = '"+x' },
  { name = 'paste',           mode = 'i', lhs = '<C-v>',      rhs = '"+gP' },
  { name = 'paste',           mode = 'c', lhs = '<C-v>',      rhs = '<C-r><C-r>+' },
  { name = 'paste register',  mode = 'n', lhs = '<C-p>',      rhs = '"' },
  { name = 'paste register',  mode = 'i', lhs = '<C-p>',      rhs = '<C-o>"' },
  { name = 'redo',            mode = 'i', lhs = '<C-r>',      rhs = '<C-o><C-r>'  },
  { name = 'undo',            mode = 'n', lhs = '<C-z>',      rhs = 'u'  },
  { name = 'undo',            mode = 'i', lhs = '<C-z>',      rhs = '<C-o>u'  },
  { name = 'save',            mode = 'n', lhs = '<C-s>',      rhs = ':update<CR>'  },
  { name = 'save',            mode = 'i', lhs = '<C-s>',      rhs = '<Esc>:update<CR>gi' },
  { name = 'save',            mode = 'v', lhs = '<C-s>',      rhs = '<C-c>:update<CR>'  },
  { name = 'split right',     mode = 'n', lhs = '<C-Right>',  rhs = ':vsp<Enter>'  },
  { name = 'split down',      mode = 'n', lhs = '<C-Down>',   rhs = ':sp<Enter>'  },
  { name = 'move text down',  mode = 'n', lhs = '<A-Down>',   rhs = ':m .+1<CR>=='},
  { name = 'move text up',    mode = 'n', lhs = '<A-Up>',     rhs = ':m .-2<CR>=='},
  { name = 'move text down',  mode = 'i', lhs = '<A-Down>',   rhs = '<Esc>:m .+1<CR>==gi' },
  { name = 'move text up',    mode = 'i', lhs = '<A-Up>',     rhs = '<Esc>:m .-2<CR>==gi' },
  { name = 'move text down',  mode = 'v', lhs = '<A-Down>',   rhs = ":m '>+1<CR>gv=gv" },
  { name = 'move text up',    mode = 'v', lhs = '<A-Up>',     rhs = ":m '<-2<CR>gv=gv" },
  { name = 'jump back',       mode = 'n', lhs = '<A-Left>',   rhs = '<C-o>'  },
  { name = 'jump forward',    mode = 'n', lhs = '<A-Right>',  rhs = '<C-i>'  },
  { name = 'indent',          mode = 'n', lhs = '<Tab>',      rhs = '>>'},
  { name = 'indent',          mode = 'v', lhs = '<Tab>',      rhs = '>gv' },
  { name = 'reverse indent',  mode = 'n', lhs = '<S-Tab>',    rhs = '<<'},
  { name = 'reverse indent',  mode = 'v', lhs = '<S-Tab>',    rhs = '<gv' },
  { name = 'reverse indent',  mode = 'i', lhs = '<S-Tab>',    rhs = '<C-D>'  },
--         'clear highlighting'           lhs = '<C-l'>''     note: this is inherited from tpope/sensible
}

M.telescope_keymaps = function(builtin) return {
  { name = 'find files',      mode = 'n', lhs = '<leader>ff', rhs = builtin.find_files               },
  { name = 'live grep',       mode = 'n', lhs = '<leader>fg', rhs = builtin.live_grep                },
  { name = 'buffers',         mode = 'n', lhs = '<leader>fb', rhs = builtin.buffers                  },
  { name = 'help tags',       mode = 'n', lhs = '<leader>fh', rhs = builtin.help_tags                },
} end

M.trouble_keymaps = {
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tt', rhs = '<cmd>TroubleToggle<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>td', rhs = '<cmd>TroubleToggle document_diagnostics<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tw', rhs = '<cmd>TroubleToggle workspace_diagnostics<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tq', rhs = '<cmd>TroubleToggle quickfix<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tl', rhs = '<cmd>TroubleToggle loclist<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tr', rhs = '<cmd>TroubleToggle lsp_references<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>ty', rhs = '<cmd>TroubleToggle lsp_type_definitions<cr>' },
  { name = 'toggle trouble',      mode = 'n', lhs = '<leader>tf', rhs = '<cmd>TroubleToggle lsp_definitions<cr>' },
}

M.comment_keymaps = {
  toggler = {
      line = '<C-_>', -- vim sees <C-/> as <C-_> *shrug*
      block = 'gbc',
  },
  opleader = {
      line = '<C-_>',
      block = 'gb',
  },
  mappings = {
      basic = true,
      extra = false,
  },
}

M.incremental_selection_keymaps = {
  init_selection = 'gnn',
  node_incremental = 'grn',
  scope_incremental = 'grc',
  node_decremental = 'grm',
}

M.textobjects_select_keymaps = {
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
}

-- NOTE: Uses ; and , for foward and backward repeats
-- also supports repeats for f, F, t, T
M.textobjects_move_keymaps = {
  goto_next_start = {
    ["<leader>;aa"] = "@parameter.outer",
    ["<leader>;ia"] = "@parameter.inner",
    ["<leader>;af"] = "@function.outer",
    ["<leader>;if"] = "@function.inner",
  },
  goto_next_end = {
    ["<leader>;aA"] = "@parameter.outer",
    ["<leader>;iA"] = "@parameter.inner",
    ["<leader>;aF"] = "@function.outer",
    ["<leader>;iF"] = "@function.inner",
  },
  goto_previous_start = {
    ["<leader>,aa"] = "@parameter.outer",
    ["<leader>,ia"] = "@parameter.inner",
    ["<leader>,af"] = "@function.outer",
    ["<leader>,if"] = "@function.inner",
  },
  goto_previous_end = {
    ["<leader>,aA"] = "@parameter.outer",
    ["<leader>,iA"] = "@parameter.inner",
    ["<leader>,aF"] = "@function.outer",
    ["<leader>,iF"] = "@function.inner",
  },
  goto_next = {
    ["<leader>;;"] = "@function.outer",
  },
  goto_previous = {
    ["<leader>,,"] = "@function.outer",
  },
}

-- TODO: Setup non-default trouble and cmpe keybinds (if I so choose)

utils.end_script(name)
return M
