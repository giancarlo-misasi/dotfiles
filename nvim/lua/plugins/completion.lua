local keymaps = require("config.keymaps")
local km = keymaps.autocomplete;

return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    event = "VeryLazy",
    opts = {
      keymap = {
        preset = 'none',
        [km.confirm] = { 'accept', 'fallback' },
        [km.complete] =
        {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            else
              return cmp.select_and_accept()
            end
          end,
          'fallback'
        },
        [km.move_up] = { 'select_prev', 'fallback' },
        [km.move_down] = { 'select_next', 'fallback' },
        [km.toggle] = { 'show', 'show_documentation', 'hide_documentation' },
        [km.hide] = { 'hide', 'fallback' },
      },
      enabled = function()
        return vim.bo.buftype ~= "prompt"
          and vim.bo.filetype ~= "TelescopePrompt"
          and vim.bo.filetype ~= "DressingInput"
          and vim.b.completion ~= false
      end,
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
        },
        trigger = {
          show_in_snippet = false, -- disabled for better tabbing through snippets
        },
      },
      sources = {
        cmdline = {}, -- disabling due to crashes
      },
    },
  },
}
