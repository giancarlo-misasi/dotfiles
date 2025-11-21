-- send unamed yanks to system clipboard an highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function(event)
    vim.fn.setreg("+", vim.fn.getreg('"'), event.regtype)
    vim.highlight.on_yank()
  end
})

-- close various buffer types with q
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "qf", "help", "man", "netrw", "lspinfo", "oil" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":close<CR>", { noremap = true, silent = true })
  end
})

-- set cwd on launch (so I can use relative paths and telescope isnt broken)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local dir = require("oil").get_current_dir()
    if dir ~= nil then
      vim.cmd('cd ' .. dir)
    else
      vim.cmd("cd %:p:h")
    end
  end,
})

-- terminal improvements
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(event)
    local buf_name = vim.api.nvim_buf_get_name(event.buf)
    if buf_name:match("%[dap%-terminal%]") then
      return
    end
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    vim.bo[event.buf].buflisted = false
    vim.cmd("setlocal statuscolumn=")
    vim.cmd("setlocal nonumber")
    vim.api.nvim_feedkeys('i', 'n', true)
  end,
})
vim.api.nvim_create_autocmd("TermClose", {
  callback = function(event)
    vim.defer_fn(function()
      vim.cmd("quit")
    end, 10)
  end,
})

-- enable treesitter folds
local max_filesize = 100 * 1024
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    vim.wo.foldmethod = "indent"
    if package.loaded["nvim-treesitter"] then
      local file_size = vim.fn.getfsize(vim.fn.expand("%:p"))
      if file_size <= max_filesize then
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end
  end,
})

-- enable lsp keymaps
local keymaps = require("config.keymaps")
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
  callback = function(event)
    for _, k in pairs(keymaps.lsp) do
      vim.keymap.set(k.mode, k.lhs, k.rhs, { desc = k.desc, buffer = event.buf })
    end
  end,
})
