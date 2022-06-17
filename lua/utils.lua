local name = 'utils'
local M = {}

M.debugging_enabled = false

M.start_script = function(script_name)
  if M.debugging_enabled then
    print('Start script ' .. script_name .. '.lua')
  end
  return M
end

M.start_script(name)

M.end_script = function(script_name)
  if M.debugging_enabled then
    print('End script ' .. script_name .. '.lua')
  end
end

M.pcall = function(module)
  local ok, m = pcall(require, module)
  if not ok and M.debugging_enabled then
    print('pcall ' .. module .. ' failed')
    print(m)
  end
  return ok, m
end

M.extend = function(original, extension)
  return vim.tbl_deep_extend('force', extension, original)
end

M.buffer_directory = function(bufname)
  return vim.fn.fnamemodify(bufname, ':p:h')
end

M.current_buffer_name = function()
  return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

M.current_buffer_directory = function()
  return M.buffer_directory(M.current_buffer_name())
end

M.path_parent = function(path)
  return vim.fn.fnamemodify(path, ':h')
end

M.path_exists = function(path)
  return vim.loop.fs_stat(path)
end

M.path_join = function(...)
  local sep = vim.loop.os_uname().version:match('Windows') and '\\' or '/'
  local result = table.concat(vim.tbl_flatten {...}, sep):gsub(sep .. '+', sep)
  return result
end

M.find_root = function(root_dir_markers)
  -- Scan markers one by one so that we can prioritize markers to search for
  for _, marker in ipairs(root_dir_markers) do
    local dirname = M.current_buffer_directory()
    while not (M.path_parent(dirname) == dirname) do
      if M.path_exists(M.path_join(dirname, marker)) then
        return dirname
      else
        dirname = M.path_parent(dirname)
      end
    end
  end
end

M.read_lines = function(file_path)
  local lines = {}
  if not M.path_exists then
    return lines
  end
  local file = io.open(file_path, "r")
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  end
  return lines
end

M.reformat_lines = function(lines, format_string)
  local reformatted_lines = {}
  for _, line in ipairs(lines) do
    table.insert(reformatted_lines, string.format(format_string, line))
  end
  return reformatted_lines
end

M.end_script(name)
return M
