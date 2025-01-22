local M = {}

-- Modes
--   normal_mode = n
--   insert_mode = i
--   visual_mode = x
--   command_mode = c

M.nops = {
  { lhs = "q",     rhs = "<Nop>" },
  { lhs = "s",     rhs = "<Nop>" },
  { lhs = "S",     rhs = "<Nop>" },
  { lhs = "r",     rhs = "<Nop>" },
  { lhs = "R",     rhs = "<Nop>" },
  { lhs = "J",     rhs = "<Nop>" },
  { lhs = "H",     rhs = "<Nop>" },
  { lhs = "L",     rhs = "<Nop>" },
  { lhs = "M",     rhs = "<Nop>" },
  { lhs = "<C-b>", rhs = "<Nop>" },
  { lhs = "<C-f>", rhs = "<Nop>" },
}

-- Note: All keymaps here use noremap=true so that we can map to things that I have no-opped
M.editing = {
  -- escape terminal
  { desc = "Escape terminal",     mode = "t", lhs = "<ESC>",     rhs = "<C-\\><C-n>" },
  -- clear highlighting on escape
  { desc = "Clear highlighting",  mode = "n", lhs = "<ESC>",     rhs = "<CMD>noh<CR><ESC>" },
  -- jump movement
  { desc = "Jump list back",      mode = "n", lhs = "<A-Left>",  rhs = "<C-o>" },
  { desc = "Jump list forward",   mode = "n", lhs = "<A-Right>", rhs = "<C-i>" },
  { desc = "Jump down & center",  mode = "n", lhs = "<C-d>",     rhs = "<C-d>zz" },
  { desc = "Jump up & center",    mode = "n", lhs = "<C-u>",     rhs = "<C-u>zz" },
  -- selection
  { desc = "Select all",          mode = "n", lhs = "<C-a>",     rhs = "ggVG" },
  { desc = "Select all",          mode = "i", lhs = "<C-a>",     rhs = "<ESC>ggVG" },
  { desc = "Select all",          mode = "x", lhs = "<C-a>",     rhs = "<ESC>ggVG" },
  -- copy / paste
  { desc = "Copy",                mode = "x", lhs = "<C-c>",     rhs = '"+y' },
  { desc = "Cut",                 mode = "x", lhs = "<C-x>",     rhs = '"+x' },
  -- undo / redo
  { desc = "Undo",                mode = "n", lhs = "<C-z>",     rhs = "u" },
  { desc = "Undo",                mode = "i", lhs = "<C-z>",     rhs = "<C-o>u" },
  { desc = "Undo",                mode = "x", lhs = "<C-z>",     rhs = "<ESC>u" },
  { desc = "Redo",                mode = "n", lhs = "<C-y>",     rhs = "<C-r>" },
  { desc = "Redo",                mode = "i", lhs = "<C-y>",     rhs = "<C-o><C-r>" },
  { desc = "Redo",                mode = "x", lhs = "<C-y>",     rhs = "<ESC><C-r>" },
  { desc = "Save",                mode = "n", lhs = "<C-s>",     rhs = "<CMD>update<CR>" },
  { desc = "Save",                mode = "i", lhs = "<C-s>",     rhs = "<ESC><CMD>update<CR>gi" },
  { desc = "Save",                mode = "x", lhs = "<C-s>",     rhs = "<ESC><CMD>update<CR>" },
  -- text movement
  { desc = "Move text down",      mode = "n", lhs = "<A-Down>",  rhs = "<CMD>m .+1<CR>==" },
  { desc = "Move text down",      mode = "i", lhs = "<A-Down>",  rhs = "<ESC><CMD>m .+1<CR>==gi" },
  { desc = "Move text down",      mode = "x", lhs = "<A-Down>",  rhs = "<CMD>m '>+1<CR>gv=gv" },
  { desc = "Move text up",        mode = "n", lhs = "<A-Up>",    rhs = "<CMD>m .-2<CR>==" },
  { desc = "Move text up",        mode = "i", lhs = "<A-Up>",    rhs = "<ESC><CMD>m .-2<CR>==gi" },
  { desc = "Move text up",        mode = "x", lhs = "<A-Up>",    rhs = "<CMD>m '<-2<CR>gv=gv" },
  { desc = "Indent",              mode = "n", lhs = "<Tab>",     rhs = ">>" },
  { desc = "Indent",              mode = "x", lhs = "<Tab>",     rhs = ">gv" },
  { desc = "Reverse indent",      mode = "n", lhs = "<S-Tab>",   rhs = "<<" },
  { desc = "Reverse indent",      mode = "i", lhs = "<S-Tab>",   rhs = "<C-D>" },
  { desc = "Reverse indent",      mode = "x", lhs = "<S-Tab>",   rhs = "<gv" },
  -- split movement
  { desc = "Move to upper split", mode = "n", lhs = "<C-Up>",    rhs = "<C-w>k" },
  { desc = "Move to lower split", mode = "n", lhs = "<C-Down>",  rhs = "<C-w>j" },
  { desc = "Move to left split",  mode = "n", lhs = "<C-Left>",  rhs = "<C-w>h" },
  { desc = "Move to right split", mode = "n", lhs = "<C-Right>", rhs = "<C-w>l" },
  -- commands
  { desc = "Actions",             mode = "n", lhs = "<F1>",      rhs = "<CMD>Actions<CR>" },
  { desc = "Buffers",             mode = "n", lhs = "<leader>b", rhs = "<CMD>Buffers<CR>" },
  { desc = "LiveGrep",            mode = "n", lhs = "<leader>g", rhs = "<CMD>LiveGrep<CR>" },
  { desc = "FindFiles",           mode = "n", lhs = "<leader>f", rhs = "<CMD>FindFiles<CR>" },
  { desc = "FileTree",            mode = "n", lhs = "<leader>t", rhs = "<CMD>FileTree<CR>" },
  { desc = "CodeActions",         mode = "n", lhs = "<leader>a", rhs = "<CMD>CodeActions<CR>" },
  { desc = "Search file",         mode = "n", lhs = "<C-f>",     rhs = "<CMD>FindText<CR>" },
  { desc = "Replace text",        mode = "n", lhs = "<C-h>",     rhs = "<CMD>ReplaceText<CR>" },
  { desc = "Replace text",        mode = "x", lhs = "<C-h>",     rhs = "<CMD>ReplaceText<CR>" },
  { desc = "Flash jump",          mode = "n", lhs = "s",         rhs = "<CMD>FlashJump<CR>" },
  { desc = "Flash jump",          mode = "x", lhs = "s",         rhs = "<CMD>FlashJump<CR>" },
  { desc = "Flash jump",          mode = "o", lhs = "s",         rhs = "<CMD>FlashJump<CR>" },
  { desc = "Flash remote",        mode = "o", lhs = "r",         rhs = "<CMD>FlashRemote<CR>" },
  { desc = "Flash toggle",        mode = "c", lhs = "<C-s>",     rhs = "<CMD>FlashToggle<CR>" },
  { desc = "Debug",               mode = "n", lhs = "<F5>",      rhs = "<CMD>StartDebug<CR>" },
  { desc = "Toggle debug ui",     mode = "n", lhs = "<F6>",      rhs = "<CMD>ToggleDebugUi<CR>" },
  { desc = "Toggle lsp",          mode = "n", lhs = "<F9>",      rhs = "<CMD>ToggleLsp<CR>" },
}

M.autocomplete = {
  confirm = "<CR>",
  complete = "<Tab>",
  move_up = "<Up>",
  move_down = "<Down>",
  docs_up = "<C-u>",
  docs_down = "<C-d>",
  toggle = "<C-Space>",
  hide = "<C-c>",
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
  insert = false,        -- "<C-g>s",
  insert_line = false,   -- "<C-g>S"
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
  { desc = "Hover",           mode = "n", lhs = "K",  rhs = "<CMD>LspHover<CR>" },
  { desc = "Show references", mode = "n", lhs = "gr", rhs = "<CMD>LspRef<CR>" },
  { desc = "Show signature",  mode = "n", lhs = "gs", rhs = "<CMD>LspSig<CR>" },
  { desc = "Goto defn",       mode = "n", lhs = "gd", rhs = "<CMD>LspDefn<CR>" },
  { desc = "Goto decl",       mode = "n", lhs = "gD", rhs = "<CMD>LspDecl<CR>" },
  { desc = "Goto impl",       mode = "n", lhs = "gi", rhs = "<CMD>LspImpl<CR>" },
  { desc = "Goto type",       mode = "n", lhs = "gy", rhs = "<CMD>LspTypeDef<CR>" },
}

return M
