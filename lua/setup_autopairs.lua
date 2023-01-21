local name = 'setuo_autopairs'
local utils = require('utils').start_script(name)

local m = require('nvim-autopairs')
m.setup {
    check_ts = true, -- enable treesitter integration
}

-- Enable insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

utils.end_script(name)
