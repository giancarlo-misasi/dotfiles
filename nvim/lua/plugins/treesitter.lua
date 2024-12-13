local keymaps = require("modules.keymaps")

local languages = {
    "c",
    "cpp",
    "rust",
    "lua",
    "go",
    "python",
    "java",
    "markdown",
}

if not unpack then
  unpack = table.unpack
end

local function repeatably_do(func, opts, additional_args)
    local tsrm = require("nvim-treesitter.textobjects.repeatable_move")
    opts = opts or {}
    additional_args = additional_args or {}
    tsrm.last_move = {
      func = func,
      opts = opts,
      additional_args = additional_args,
    }
    func(opts, unpack(additional_args))
end

local function search_forward(opts)
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

local function center(func)
  return function()
    func()
    vim.cmd('normal! zz')
  end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = languages,
                auto_install = true,
                indent = true,
                incremental_selection = false,
                highlight = { enable = true },
                textobjects = {
                    swap = false,
                    select = {
                        enable = true,
                        lookahead = true,
                        include_surrounding_whitespace = true,
                        keymaps = keymaps.textobjects_select,
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V",  -- linewise
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = keymaps.textobjects_move.goto_next_start,
                        goto_next_end = keymaps.textobjects_move.goto_next_end,
                        goto_previous_start = keymaps.textobjects_move.goto_previous_start,
                        goto_previous_end = keymaps.textobjects_move.goto_previous_end,
                        goto_next = {},
                        goto_previous = {},
                    },
                },
            })

            -- repeat treesitter moves
            local rm = require("nvim-treesitter.textobjects.repeatable_move")
            local nxo = { 'n', 'x', 'o' }
            local map = vim.keymap.set
            local keys = keymaps.textobjects_move_repeat
            map(nxo, ";",                     center(rm.repeat_last_move_next),                                 { desc = "repeat forward" })
            map(nxo, ",",                     center(rm.repeat_last_move_previous),                             { desc = "repeat back" })
            map(nxo, "f",                     center(rm.builtin_f))
            map(nxo, "F",                     center(rm.builtin_F))
            map(nxo, "t",                     center(rm.builtin_t))
            map(nxo, "T",                     center(rm.builtin_T))
            map(nxo, ']' .. keys.diagnostic,  center(diagnostic_jump({ forward = true })),                      { desc = 'next diagnostic' })
            map(nxo, '[' .. keys.diagnostic,  center(diagnostic_jump({ forward = false })),                     { desc = 'previous diagnostic' })
            map(nxo, ']' .. keys.error,       center(diagnostic_jump({ forward = true, severity = 'ERROR' })),  { desc = 'next error' })
            map(nxo, '[' .. keys.error,       center(diagnostic_jump({ forward = false, severity = 'ERROR' })), { desc = 'previous error' })
            map(nxo, ']' .. keys.warn,        center(diagnostic_jump({ forward = true, severity = 'WARN' })),   { desc = 'next warning' })
            map(nxo, '[' .. keys.warn,        center(diagnostic_jump({ forward = false, severity = 'WARN' })),  { desc = 'previous warning' })
            map(nxo, ']' .. keys.info,        center(diagnostic_jump({ forward = true, severity = 'INFO' })),   { desc = 'next info' })
            map(nxo, '[' .. keys.info,        center(diagnostic_jump({ forward = false, severity = 'INFO' })),  { desc = 'previous info' })
            map(nxo, ']' .. keys.hint,        center(diagnostic_jump({ forward = true, severity = 'HINT' })),   { desc = 'next hint' })
            map(nxo, '[' .. keys.hint,        center(diagnostic_jump({ forward = false, severity = 'HINT' })),  { desc = 'previous hint' })

            -- repeat search as well
            vim.api.nvim_create_autocmd("CmdlineLeave", {
              pattern = "/",
              callback = function()
                local opts = { forward = true }
                rm.set_last_move(center(search_forward(opts)), opts)
              end
            })

            -- treesitter folding
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldmethod = "expr"
        end,
    },
}
