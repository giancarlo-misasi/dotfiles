local commands = {
  "command! Actions lua require('telescope').extensions.menu.action_menu{}",

  "command! SplitRight vsplit",
  "command! SplitDown split",
  "command! CloseSplit q!",
  "command! NewTab tabnew",
  "command! LoadCwdToBuffers :args **/*",
  "command! CloseTab tabclose",
  "command! CloseOtherBuffers :w|%bd|e#",

  "command! FileTree Oil",
  "command! FindFiles lua require('telescope.builtin').find_files{}",
  "command! LiveGrep lua require('telescope.builtin').live_grep{}",
  "command! RecentFiles lua require('telescope.builtin').oldfiles{}",
  "command! SearchHistory lua require('telescope.builtin').search_history{}",
  "command! SetLanguage lua require('telescope.builtin').filetypes{}",
  "command! Registers lua require('telescope.builtin').registers{}",
  "command! Commands lua require('telescope.builtin').commands{}",
  "command! CommandHistory lua require('telescope.builtin').command_history{}",
  "command! Diagnostics lua require('telescope.builtin').diagnostics{}",
  "command! Buffers lua require('telescope.builtin').buffers{}",

  "command! StartLsp lua require('modules.lsp').start()",
  "command! Debug lua require('modules.dap').start()",
  "command! Rename lua vim.lsp.buf.rename()",
  "command! FormatCode lua vim.lsp.buf.format()",
  "command! FormatBuffers bufdo FormatCode",
  "command! CodeActions lua vim.lsp.buf.code_action()",
  "command! Hover lua vim.lsp.buf.hover()",
  "command! ShowReferences lua vim.lsp.buf.references()",
  "command! ShowSignature lua vim.lsp.buf.signature_help()",
  "command! GotoDefinition lua vim.lsp.buf.definition()",
  "command! GotoDeclaration lua vim.lsp.buf.declaration()",
  "command! GotoImplementation lua vim.lsp.buf.implementation()",
  "command! GotoType lua vim.lsp.buf.type_definition()",

  "command! ToUpperCase lua require('textcase').current_word('to_upper_case')",
  "command! ToLowerCase lua require('textcase').current_word('to_lower_case')",
  "command! ToSnakeCase lua require('textcase').current_word('to_snake_case')",
  "command! ToDashCase lua require('textcase').current_word('to_dash_case')",
  "command! ToConstantCase lua require('textcase').current_word('to_constant_case')",
  "command! ToDotCase lua require('textcase').current_word('to_dot_case')",
  "command! ToCommaCase lua require('textcase').current_word('to_comma_case')",
  "command! ToPhraseCase lua require('textcase').current_word('to_phrase_case')",
  "command! ToCamelCase lua require('textcase').current_word('to_camel_case')",
  "command! ToPascalCase lua require('textcase').current_word('to_pascal_case')",
  "command! ToTitleCase lua require('textcase').current_word('to_title_case')",
  "command! ToPathCase lua require('textcase').current_word('to_path_case')",

  "command! Quit qa!",
}

local commands_by_pattern = {
  -- TODO: Replace with nvim-java commands after testing
  -- java = {
  --     "command! TestClass lua require('jdtls').test_class()",
  --     "command! TestNearestMethod lua require('jdtls').test_nearest_method()",
  --     "command! OrganizeImports lua require('jdtls').organize_imports()",
  --     "command! ExtractVariable lua require('jdtls').extract_variable()",
  --     "command! ExtractConstant lua require('jdtls').extract_constant()",
  --     "command! ExtractMethod lua require('jdtls').extract_method()",
  -- },
}

local function setup_commands()
  for _, cmd in pairs(commands) do
    local status, exception = pcall(function()
      vim.api.nvim_command(cmd)
    end)
    if not status then
      print("failed to set command " .. cmd .. ": " .. exception)
    end
  end
end

local function setup_commands_by_pattern()
  for pattern, command_list in pairs(commands_by_pattern) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        for _, cmd in pairs(command_list) do
          local status, exception = pcall(function()
            vim.api.nvim_command(cmd)
          end)
          if not status then
            print("failed to set command " .. cmd .. ": " .. exception)
          end
        end
      end,
    })
  end
end

local function setup_highlight_on_yank()
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end
  })
end

local function setup_q_close_for_buffers()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'qf', 'help', 'man', 'netrw', 'lspinfo' },
    callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
    end
  })
end

local function setup_start_terminals_in_insert()
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
  })
end

setup_commands()
setup_commands_by_pattern()
setup_highlight_on_yank()
setup_q_close_for_buffers()
setup_start_terminals_in_insert()
