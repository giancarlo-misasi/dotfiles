local M = {}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c

M.nops = {
    { lhs = "q", rhs = "<Nop>" },
    { lhs = "J", rhs = "<Nop>" },
    { lhs = "H", rhs = "<Nop>" },
    { lhs = "L", rhs = "<Nop>" },
    { lhs = "M", rhs = "<Nop>" },

    { lhs = "<c-b>", rhs = "<Nop>" },
    { lhs = "<c-f>", rhs = "<Nop>" },
}

-- Note: All keymaps here use noremap=true so that we can map to things that I have no-opped
M.editing = {
    -- clear highlighting on escape
    { desc = "Clear highlighting", mode = "n", lhs = "<Esc>",     rhs = ":noh<cr>" },
    -- :noh<CR>
    -- flip j and k and make them similar to up and down
    { desc = "Up",                 mode = "n", lhs = "j",         rhs = "k" },
    { desc = "Up",                 mode = "v", lhs = "j",         rhs = "k" },
    { desc = "Up",                 mode = "n", lhs = "<C-j>",     rhs = "k" },
    { desc = "Up",                 mode = "v", lhs = "<C-j>",     rhs = "k" },
    { desc = "Up",                 mode = "n", lhs = "<S-j>",     rhs = "vk" },
    { desc = "Up",                 mode = "v", lhs = "<S-j>",     rhs = "k" },
    { desc = "Down",               mode = "n", lhs = "k",         rhs = "j" },
    { desc = "Down",               mode = "v", lhs = "k",         rhs = "j" },
    { desc = "Down",               mode = "n", lhs = "<C-k>",     rhs = "j" },
    { desc = "Down",               mode = "v", lhs = "<C-k>",     rhs = "j" },
    { desc = "Down",               mode = "n", lhs = "<S-k>",     rhs = "vj" },
    { desc = "Down",               mode = "v", lhs = "<S-k>",     rhs = "j" },
    -- in normal mode, <C-Left, C-Right already works by default
    { desc = "Jump back",          mode = "i", lhs = "<C-Left>",  rhs = "<Esc>b" },
    { desc = "Jump forward",       mode = "i", lhs = "<C-Right>", rhs = "<Esc>w" },
    -- make h and l work like arrows do (can't do ctrl+shift though)
    { desc = "Jump back",          mode = "n", lhs = "<C-h>",     rhs = "b" },
    { desc = "Jump back",          mode = "v", lhs = "<C-h>",     rhs = "b" },
    { desc = "Jump back",          mode = "i", lhs = "<C-h>",     rhs = "<Esc>b" },
    { desc = "Jump back",          mode = "n", lhs = "<S-h>",     rhs = "vb" },
    { desc = "Jump back",          mode = "v", lhs = "<S-h>",     rhs = "b" },
    { desc = "Jump forward",       mode = "n", lhs = "<C-l>",     rhs = "w" },
    { desc = "Jump forward",       mode = "v", lhs = "<C-l>",     rhs = "w" },
    { desc = "Jump forward",       mode = "i", lhs = "<C-l>",     rhs = "<Esc>w" },
    { desc = "Jump forward",       mode = "n", lhs = "<S-l>",     rhs = "vw" },
    { desc = "Jump forward",       mode = "v", lhs = "<S-l>",     rhs = "w" },
    { desc = "Jump down & center", mode = "n", lhs = "<C-d>",     rhs = "<C-d>zz" },
    { desc = "Jump up & center",   mode = "n", lhs = "<C-u>",     rhs = "<C-u>zz" },
    { desc = "Next occurrence",    mode = "n", lhs = "n",         rhs = "nzzzv" },
    { desc = "Prev occurrence",    mode = "n", lhs = "N",         rhs = "Nzzzv" },
    { desc = "Select all",         mode = "n", lhs = "<C-a>",     rhs = "ggVG" },
    { desc = "Select all",         mode = "i", lhs = "<C-a>",     rhs = "<Esc>ggVG" },
    { desc = "Select all",         mode = "x", lhs = "<C-a>",     rhs = "<Esc>ggVG" },
    { desc = "Copy",               mode = "x", lhs = "<C-c>",     rhs = '"+y' },
    { desc = "Cut",                mode = "x", lhs = "<C-x>",     rhs = '"+x' },
    { desc = "Paste",              mode = "i", lhs = "<C-v>",     rhs = '"+gP' },
    { desc = "Paste",              mode = "c", lhs = "<C-v>",     rhs = "<C-r><C-r>+" },
    { desc = "Undo",               mode = "n", lhs = "<C-z>",     rhs = "u" },
    { desc = "Undo",               mode = "i", lhs = "<C-z>",     rhs = "<C-o>u" },
    { desc = "Undo",               mode = "x", lhs = "<C-z>",     rhs = "<Esc>u" },
    { desc = "Redo",               mode = "n", lhs = "<C-y>",     rhs = "<C-r>" },
    { desc = "Redo",               mode = "i", lhs = "<C-y>",     rhs = "<C-o><C-r>" },
    { desc = "Redo",               mode = "x", lhs = "<C-y>",     rhs = "<Esc><C-r>" },
    { desc = "Save",               mode = "n", lhs = "<C-s>",     rhs = ":update<CR>" },
    { desc = "Save",               mode = "i", lhs = "<C-s>",     rhs = "<Esc>:update<CR>gi" },
    { desc = "Save",               mode = "x", lhs = "<C-s>",     rhs = "<Esc>:update<CR>" },
    { desc = "Move text down",     mode = "n", lhs = "<A-Down>",  rhs = ":m .+1<CR>==" },
    { desc = "Move text down",     mode = "i", lhs = "<A-Down>",  rhs = "<Esc>:m .+1<CR>==gi" },
    { desc = "Move text down",     mode = "x", lhs = "<A-Down>",  rhs = ":m '>+1<CR>gv=gv" },
    { desc = "Move text up",       mode = "n", lhs = "<A-Up>",    rhs = ":m .-2<CR>==" },
    { desc = "Move text up",       mode = "i", lhs = "<A-Up>",    rhs = "<Esc>:m .-2<CR>==gi" },
    { desc = "Move text up",       mode = "x", lhs = "<A-Up>",    rhs = ":m '<-2<CR>gv=gv" },
    { desc = "Jump list backward", mode = "n", lhs = "<A-Left>",  rhs = "<C-o>" },
    { desc = "Jump list forward",  mode = "n", lhs = "<A-Right>", rhs = "<C-i>" },
    { desc = "Indent",             mode = "n", lhs = "<Tab>",     rhs = ">>" },
    { desc = "Indent",             mode = "x", lhs = "<Tab>",     rhs = ">gv" },
    { desc = "Reverse indent",     mode = "n", lhs = "<S-Tab>",   rhs = "<<" },
    { desc = "Reverse indent",     mode = "i", lhs = "<S-Tab>",   rhs = "<C-D>" },
    { desc = "Reverse indent",     mode = "x", lhs = "<S-Tab>",   rhs = "<gv" },
    { desc = "Actions",            mode = "n", lhs = "<F1>",      rhs = ":Actions<cr>" },
    { desc = "Buffers",            mode = "n", lhs = "<leader>b", rhs = ":Buffers<cr>" },
    { desc = "LiveGrep",           mode = "n", lhs = "<leader>g", rhs = ":LiveGrep<cr>" },
    { desc = "FindFiles",          mode = "n", lhs = "<leader>f", rhs = ":FindFiles<cr>" },
    { desc = "CodeActions",        mode = "n", lhs = "<leader>a", rhs = ":CodeActions<cr>" },
    { desc = "Find",               mode = "n", lhs = "<c-f>",     rhs = ":SearchBoxMatchAll<cr>" },
    { desc = "Replace",            mode = "n", lhs = "<c-r>",     rhs = ":SearchBoxReplace<cr>" },
}

M.autocomplete = {
    confirm = "<CR>",
    complete = "<Tab>",
    move_up = "<Up>",
    move_down = "<Down>",
    toggle = "<C-Space>",
}

M.surround = {
    normal = "ys",
    normal_cur = "yss",
    normal_line = "yS",
    normal_cur_line = "ySS",
    visual = "S",
    visual_line = "gS",
    change = "cs",
    change_line = "cS",
    delete = "ds",
    insert = false,      -- "<C-g>s",
    insert_line = false, -- "<C-g>S"
}

M.comment_operator = {
    line = "gc",
    block = "gb",
}

M.comment_toggler = {
    line = "gcc",
    block = "gbc",
}

M.textobjects_select = {
    ["aa"] = "@parameter.outer",
    ["ia"] = "@parameter.inner",
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["as"] = "@block.outer",
    ["is"] = "@block.inner",
}

M.textobjects_move = {
    goto_next_start = {
        ["]aa"] = "@parameter.outer",
        ["]ia"] = "@parameter.inner",
        ["]af"] = "@function.outer",
        ["]if"] = "@function.inner",
        ["]as"] = "@block.outer",
        ["]is"] = "@block.inner",
    },
    goto_next_end = {
        ["]aA"] = "@parameter.outer",
        ["]iA"] = "@parameter.inner",
        ["]aF"] = "@function.outer",
        ["]iF"] = "@function.inner",
        ["]aS"] = "@block.outer",
        ["]iS"] = "@block.inner",
    },
    goto_previous_start = {
        ["[aa"] = "@parameter.outer",
        ["[ia"] = "@parameter.inner",
        ["[af"] = "@function.outer",
        ["[if"] = "@function.inner",
        ["[as"] = "@block.outer",
        ["[is"] = "@block.inner",
    },
    goto_previous_end = {
        ["[aA"] = "@parameter.outer",
        ["[iA"] = "@parameter.inner",
        ["[aF"] = "@function.outer",
        ["[iF"] = "@function.inner",
        ["[aS"] = "@block.outer",
        ["[iS"] = "@block.inner",
    },
}

M.textobjects_move_repeat = {
    diagnostic = "d",
    error = "e",
    warn = "w",
    info = "i",
    hint = "h",
}

M.lsp = {
    { desc = "Hover",            mode = "n", lhs = "K",    rhs = "<cmd>lua vim.lsp.buf.hover()<cr>" },
    { desc = "Show references",  mode = "n", lhs = "gr",   rhs = "<cmd>lua vim.lsp.buf.references()<cr>" },
    { desc = "Show signature",   mode = "n", lhs = "gs",   rhs = "<cmd>lua vim.lsp.buf.signature_help()<cr>" },
    { desc = "Goto defn",        mode = "n", lhs = "gd",   rhs = "<cmd>lua vim.lsp.buf.definition()<cr>" },
    { desc = "Goto decl",        mode = "n", lhs = "gD",   rhs = "<cmd>lua vim.lsp.buf.declaration()<cr>" },
    { desc = "Goto impl",        mode = "n", lhs = "gi",   rhs = "<cmd>lua vim.lsp.buf.implementation()<cr>" },
    { desc = "Goto type",        mode = "n", lhs = "gy",   rhs = "<cmd>lua vim.lsp.buf.type_definition()<cr>" },
}

return M
