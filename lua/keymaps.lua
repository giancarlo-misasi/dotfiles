local name = 'keymaps'
local utils = require('utils').start_script(name)
local M = {}

local function setup()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- remap q to require leader key, because I can't stand it otherwise
  -- only seems to work in vimscript
  vim.cmd('noremap <Leader>q q')
  vim.cmd('noremap q <Nop>')

  -- load the basic keymaps
   M.set_keymaps(M.basic_keymaps)
end

M.set_keymaps = function(keymap_pairs)
  for _, k in pairs(keymap_pairs) do
    vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, silent = true, noremap = true })
  end
end

M.set_buf_keymaps = function(keymap_pairs)
  for _, k in pairs(keymap_pairs) do
    vim.api.nvim_buf_set_keymap(k.buffer, k.mode, k.lhs, k.rhs, { desc = k.desc, silent = true, noremap = true })
  end
end

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c

M.basic_keymaps = {
  { desc = 'Copy',            mode = 'x', lhs = '<C-c>',      rhs = '"+y' },
  { desc = 'Cut',             mode = 'x', lhs = '<C-x>',      rhs = '"+x' },
  { desc = 'Paste',           mode = 'i', lhs = '<C-v>',      rhs = '"+gP' },
  { desc = 'Paste',           mode = 'c', lhs = '<C-v>',      rhs = '<C-r><C-r>+' },
  { desc = 'Paste register',  mode = 'n', lhs = '<C-p>',      rhs = '"' },
  { desc = 'Paste register',  mode = 'i', lhs = '<C-p>',      rhs = '<C-o>"' },
  { desc = 'Redo',            mode = 'i', lhs = '<C-r>',      rhs = '<C-o><C-r>'  },
  { desc = 'Undo',            mode = 'n', lhs = '<C-z>',      rhs = 'u'  },
  { desc = 'Undo',            mode = 'i', lhs = '<C-z>',      rhs = '<C-o>u'  },
  { desc = 'Save',            mode = 'n', lhs = '<C-s>',      rhs = ':update<CR>'  },
  { desc = 'Save',            mode = 'i', lhs = '<C-s>',      rhs = '<Esc>:update<CR>gi' },
  { desc = 'Save',            mode = 'x', lhs = '<C-s>',      rhs = '<C-c>:update<CR>'  },
  { desc = 'Split right',     mode = 'n', lhs = '<C-Right>',  rhs = ':vsp<Enter>'  },
  { desc = 'Split down',      mode = 'n', lhs = '<C-Down>',   rhs = ':sp<Enter>'  },
  { desc = 'Move text down',  mode = 'n', lhs = '<A-Down>',   rhs = ':m .+1<CR>=='},
  { desc = 'Move text up',    mode = 'n', lhs = '<A-Up>',     rhs = ':m .-2<CR>=='},
  { desc = 'Move text down',  mode = 'i', lhs = '<A-Down>',   rhs = '<Esc>:m .+1<CR>==gi' },
  { desc = 'Move text up',    mode = 'i', lhs = '<A-Up>',     rhs = '<Esc>:m .-2<CR>==gi' },
  { desc = 'Move text down',  mode = 'x', lhs = '<A-Down>',   rhs = ":m '>+1<CR>gv=gv" },
  { desc = 'Move text up',    mode = 'x', lhs = '<A-Up>',     rhs = ":m '<-2<CR>gv=gv" },
  { desc = 'Jump back',       mode = 'n', lhs = '<A-Left>',   rhs = '<C-o>'  },
  { desc = 'Jump forward',    mode = 'n', lhs = '<A-Right>',  rhs = '<C-i>'  },
  { desc = 'Indent',          mode = 'n', lhs = '<Tab>',      rhs = '>>'},
  { desc = 'Indent',          mode = 'x', lhs = '<Tab>',      rhs = '>gv' },
  { desc = 'Reverse indent',  mode = 'n', lhs = '<S-Tab>',    rhs = '<<'},
  { desc = 'Reverse indent',  mode = 'x', lhs = '<S-Tab>',    rhs = '<gv' },
  { desc = 'Reverse indent',  mode = 'i', lhs = '<S-Tab>',    rhs = '<C-D>'  },
  { desc = 'Find folders',    mode = 'n', lhs = '<leader>w',  rhs = function() vim.cmd(':Texplore ' .. utils.cwd() .. '<cr>') end },
  { desc = 'CD to buf dir',   mode = 'n', lhs = '<leader>c',  rhs = function() vim.cmd(':cd ' .. utils.current_buffer_directory()) end },
  { desc = 'CD up 1 dir',     mode = 'n', lhs = '<leader><Up>',rhs = function() vim.cmd(':cd ..') end },
  { desc = 'Format',          mode = 'n', lhs = '<A-f>',      rhs = function() vim.cmd(':LspZeroFormat!') end },
--         'clear highlighting'           lhs = '<C-l'>''     note: this is inherited from tpope/sensible
}

setup() -- Setup the basic keybinds, all others setup in respective setup_ files

M.lsp_keymaps = function(buffer) return {
  -- { desc = 'goto def',        mode = 'n', lhs = 'gd',         rhs = '<cmd>lua vim.lsp.buf.definition()<cr>', buffer = buffer },
  -- { desc = 'goto typedef',    mode = 'n', lhs = 'gy',         rhs = '<cmd>lua vim.lsp.buf.type_definition()<cr>', buffer = buffer },
  -- { desc = 'find references', mode = 'n', lhs = 'gr',         rhs = '<cmd>lua vim.lsp.buf.references()<cr>', buffer = buffer },
  { desc = 'Goto decl',       mode = 'n', lhs = 'gD',         rhs = '<cmd>lua vim.lsp.buf.declaration()<cr>', buffer = buffer },
  { desc = 'Goto impl',       mode = 'n', lhs = 'gi',         rhs = '<cmd>lua vim.lsp.buf.implementation()<cr>', buffer = buffer },
  { desc = 'Code action',     mode = 'n', lhs = '<leader>a',  rhs = '<cmd>lua vim.lsp.buf.code_action()<cr>', buffer = buffer },
  { desc = 'Hover',           mode = 'n', lhs = 'K',          rhs = '<cmd>lua vim.lsp.buf.hover()<cr>', buffer = buffer },
  { desc = 'Signature',       mode = 'n', lhs = '<C-k>',      rhs = '<cmd>lua vim.lsp.buf.signature_help()<cr>', buffer = buffer },
  { desc = 'Rename',          mode = 'n', lhs = '<F2>',       rhs = '<cmd>lua vim.lsp.buf.rename()<cr>', buffer = buffer },
} end

M.trouble_keymaps = {
  { desc = 'Goto definition', mode = 'n', lhs = 'gd',         rhs = '<cmd>Trouble lsp_definitions<cr>' },
  { desc = 'Goto typedef',    mode = 'n', lhs = 'gy',         rhs = '<cmd>Trouble lsp_type_definitions<cr>' },
  { desc = 'List references', mode = 'n', lhs = 'gr',         rhs = '<cmd>Trouble lsp_references<cr>' },
  { desc = 'List quickfix',   mode = 'n', lhs = '<leader>x',  rhs = '<cmd>Trouble quickfix<cr>' },
  { desc = 'List locations',  mode = 'n', lhs = '<leader>l',  rhs = '<cmd>Trouble loclist<cr>' },
}

M.telescope_keymaps = function(builtin) return {
  { desc = 'Find files',      mode = 'n', lhs = '<leader>f',  rhs = function() builtin.find_files({ cwd = utils.cwd() }) end },
  { desc = 'Find recent',     mode = 'n', lhs = '<leader>o',  rhs = builtin.oldfiles },
  { desc = 'Find paste',      mode = 'n', lhs = '<leader>p',  rhs = builtin.registers },
  { desc = 'Find ast',        mode = 'n', lhs = '<leader>t',  rhs = builtin.treesitter },
} end

M.cmp_keymaps = function(cmp, luasnip) return {
    -- confirm selection
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),

    -- scroll up and down in the completion documentation
    ['<C-f>'] = cmp.mapping.scroll_docs(5),
    ['<C-u>'] = cmp.mapping.scroll_docs(-5),

    -- toggle completion
    ['<C-Space>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),

    -- tab completion
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i','s'}),

    -- reverse snippet jumping
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i','s'}),
} end

M.comment_keymaps = {
  toggler = {
      line = '<C-_>', -- vim sees <C-/> as <C-_>
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
    ["]aa"] = "@parameter.outer",
    ["]ia"] = "@parameter.inner",
    ["]af"] = "@function.outer",
    ["]if"] = "@function.inner",
  },
  goto_next_end = {
    ["]aA"] = "@parameter.outer",
    ["]iA"] = "@parameter.inner",
    ["]aF"] = "@function.outer",
    ["]iF"] = "@function.inner",
  },
  goto_previous_start = {
    ["[aa"] = "@parameter.outer",
    ["[ia"] = "@parameter.inner",
    ["[af"] = "@function.outer",
    ["[if"] = "@function.inner",
  },
  goto_previous_end = {
    ["[aA"] = "@parameter.outer",
    ["[iA"] = "@parameter.inner",
    ["[aF"] = "@function.outer",
    ["[iF"] = "@function.inner",
  },
  goto_next = {},
  goto_previous = {},
}

M.set_treesitter_repeat_keymaps = function()
  local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

  -- Repeat movement with ; and ,
  -- ensure ; goes forward and , goes backward regardless of the last direction
  vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
  vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

  -- Make builtin f, F, t, T also repeatable with ; and ,
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
  vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
  vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
end

M.telescope_dialog_keymaps = function(actions, config) return {
  i = {
    ["<C-n>"] = actions.move_selection_next,
    ["<C-p>"] = actions.move_selection_previous,

    ["<C-c>"] = actions.close,

    ["<Down>"] = actions.move_selection_next,
    ["<Up>"] = actions.move_selection_previous,

    ["<CR>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,
    ["<C-t>"] = actions.select_tab,

    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,

    ["<PageUp>"] = actions.results_scrolling_up,
    ["<PageDown>"] = actions.results_scrolling_down,

    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    ["<C-l>"] = actions.complete_tag,
    ["<C-/>"] = actions.which_key,
    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    ["<C-w>"] = { "<c-s-w>", type = "command" },

    -- disable c-j because we dont want to allow new lines #2123
    ["<C-j>"] = actions.nop,
  },

  n = {
    ["<esc>"] = actions.close,
    ["<CR>"] = actions.select_default,
    ["<C-x>"] = actions.select_horizontal,
    ["<C-v>"] = actions.select_vertical,
    ["<C-t>"] = actions.select_tab,

    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

    -- TODO: This would be weird if we switch the ordering.
    ["j"] = actions.move_selection_next,
    ["k"] = actions.move_selection_previous,
    ["H"] = actions.move_to_top,
    ["M"] = actions.move_to_middle,
    ["L"] = actions.move_to_bottom,

    ["<Down>"] = actions.move_selection_next,
    ["<Up>"] = actions.move_selection_previous,
    ["gg"] = actions.move_to_top,
    ["G"] = actions.move_to_bottom,

    ["<C-u>"] = actions.preview_scrolling_up,
    ["<C-d>"] = actions.preview_scrolling_down,

    ["<PageUp>"] = actions.results_scrolling_up,
    ["<PageDown>"] = actions.results_scrolling_down,

    ["?"] = actions.which_key,
  },
} end

utils.end_script(name)
return M
