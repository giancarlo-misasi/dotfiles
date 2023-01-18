local name = 'keymaps'
local utils = require('utils').start_script(name)

function set_keymaps(keymap_pairs)
  for _, k in pairs(keymap_pairs) do
    if not k.buf then
      vim.keymap.set(k.mode, k.lhs, k.rhs)
    end
  end
end

function set_plugin_keymaps(module, keymap_pair_function)
  local ok, builtin = utils.pcall(module)
  if ok then
    set_keymaps(keymap_pair_function(builtin))
  else
    print('sad face' ..  module)
  end
end

-- Remap leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = v
--   visual_block_mode = x
--   term_mode = t
--   command_mode = c

local basic_keymaps = {
  { name = 'copy',            mode = 'v', lhs = '<C-c>',      rhs = '"+y'                            },
  { name = 'cut',             mode = 'v', lhs = '<C-x>',      rhs = '"+x'                            },
  { name = 'paste',           mode = 'i', lhs = '<C-v>',      rhs = '"+gP'                           },
  { name = 'paste',           mode = 'c', lhs = '<C-v>',      rhs = '<C-r><C-r>+'                    },
  { name = 'paste register',  mode = 'n', lhs = '<C-p>',      rhs = '"'                              },
  { name = 'paste register',  mode = 'i', lhs = '<C-p>',      rhs = '<C-o>"'                         },
  { name = 'redo',            mode = 'i', lhs = '<C-r>',      rhs = '<C-o><C-r>'                     },
  { name = 'undo',            mode = 'n', lhs = '<C-z>',      rhs = 'u'                              },
  { name = 'undo',            mode = 'i', lhs = '<C-z>',      rhs = '<C-o>u'                         },
  { name = 'save',            mode = 'n', lhs = '<C-s>',      rhs = ':update<CR>'                    },
  { name = 'save',            mode = 'i', lhs = '<C-s>',      rhs = '<Esc>:update<CR>gi'             },
  { name = 'save',            mode = 'v', lhs = '<C-s>',      rhs = '<C-c>:update<CR>'               },
  { name = 'split right',     mode = 'n', lhs = '<C-Right>',  rhs = ':vsp<Enter>'                    },
  { name = 'split down',      mode = 'n', lhs = '<C-Down>',   rhs = ':sp<Enter>'                     },
  { name = 'move text down',  mode = 'n', lhs = '<A-Down>',   rhs = ':m .+1<CR>=='                   },
  { name = 'move text up',    mode = 'n', lhs = '<A-Up>',     rhs = ':m .-2<CR>=='                   },
  { name = 'move text down',  mode = 'i', lhs = '<A-Down>',   rhs = '<Esc>:m .+1<CR>==gi'            },
  { name = 'move text up',    mode = 'i', lhs = '<A-Up>',     rhs = '<Esc>:m .-2<CR>==gi'            },
  { name = 'move text down',  mode = 'v', lhs = '<A-Down>',   rhs = ":m '>+1<CR>gv=gv"               },
  { name = 'move text up',    mode = 'v', lhs = '<A-Up>',     rhs = ":m '<-2<CR>gv=gv"               },
  { name = 'jump back',       mode = 'n', lhs = '<A-Left>',   rhs = '<C-o>'                          },
  { name = 'jump forward',    mode = 'n', lhs = '<A-Right>',  rhs = '<C-i>'                          },
  { name = 'indent',          mode = 'n', lhs = '<Tab>',      rhs = '>>'                             },
  { name = 'indent',          mode = 'v', lhs = '<Tab>',      rhs = '>gv'                            },
  { name = 'reverse indent',  mode = 'n', lhs = '<S-Tab>',    rhs = '<<'                             },
  { name = 'reverse indent',  mode = 'v', lhs = '<S-Tab>',    rhs = '<gv'                            },
  { name = 'reverse indent',  mode = 'i', lhs = '<S-Tab>',    rhs = '<C-D>'                          },
}

function substitute_keymaps(builtin)
  return {
    { name = 'substitute',      mode = 'n', lhs = '<leader>s',  rhs = builtin.operator               },
    { name = 'substitute',      mode = 'x', lhs = '<leader>s',  rhs = builtin.visual                 },
    { name = 'substitute line', mode = 'n', lhs = '<leader>ss', rhs = builtin.line                   },
    { name = 'substitute eol',  mode = 'n', lhs = '<leader>se', rhs = builtin.eol                    },
  }
end

function telescope_keymaps(builtin)
  return {
  { name = 'find files',      mode = 'n', lhs = '<leader>ff', rhs = builtin.find_files               },
  { name = 'live grep',       mode = 'n', lhs = '<leader>fg', rhs = builtin.live_grep                },
  { name = 'buffers',         mode = 'n', lhs = '<leader>fb', rhs = builtin.buffers                  },
  { name = 'help tags',       mode = 'n', lhs = '<leader>fh', rhs = builtin.help_tags                },
  }
end

set_keymaps(basic_keymaps)
set_plugin_keymaps('substitute', substitute_keymaps)
set_plugin_keymaps('telescope.builtin', telescope_keymaps)

utils.end_script(name)
