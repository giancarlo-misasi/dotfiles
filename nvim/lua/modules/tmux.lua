local M = {}

local num_tabs = 0
local current_tab = 1
local running = false
local last_update_time = 0
local update_interval = 60000 -- once a minute outside focus lost should be enough

local function update_status(current_time)
  local tmux_str = os.getenv("TMUX")
  if tmux_str == nil then
    num_tabs = 0
    current_tab = 1
  else
    num_tabs = #vim.fn.systemlist('tmux list-windows -F "#W"')
    current_tab = math.floor(tonumber(vim.fn.system("tmux display-message -p '#I'")) or 1)
  end
  last_update_time = current_time
  running = false
  require("lualine").refresh()
end

local function update_status_async(force)
  if running then
    return
  end

  local current_time = vim.loop.hrtime() / 1e6
  if force or (current_time - last_update_time >= update_interval) then
    running = true

    local async = vim.loop.new_async(vim.schedule_wrap(function()
      update_status(current_time)
    end))

    async:send()
  end
end

local function hl(group, content)
  return "%#" .. group .. "# " .. content .. "%#StatusLine#"
end

local function click(method, idx)
  return string.format("%%%s@" .. method .. "@%s%%T", idx, idx)
end

M.prompt_commands = function()
  if os.getenv("TMUX") ~= nil then
    vim.cmd("silent !$HOME/.tmux/scripts/tmux-commands.sh")
  else
    vim.notify("There is no active tmux session at this time.")
  end
end

M.show_statusline = function()
  vim.cmd("silent !tmux set -g status on")
  update_status_async(true)
end

M.hide_statusline = function()
  vim.cmd("silent !tmux set -g status off")
  update_status_async(true)
end

M.icon = {
  function() return [[]] end,
  cond = function()
    update_status_async(false)
    return num_tabs > 0
  end,
  on_click = M.prompt_commands,
}

M.tabs = {
  function()
    local tabs = {}
    for i = 1, num_tabs do
      if i == current_tab then
        table.insert(tabs, hl("TmuxWindowActive", click("TmuxSwitchWindow", i)))
      else
        table.insert(tabs, hl("TmuxWindowInactive", click("TmuxSwitchWindow", i)))
      end
    end
    return table.concat(tabs, " ")
  end,
  cond = function()
    return num_tabs > 1
  end,
}

vim.cmd([[
  highlight TmuxWindowActive guibg=#242424 guifg=#DEEEED
  highlight TmuxWindowInactive guibg=#242424 guifg=#888888
  function! TmuxSwitchWindow(idx, mouseclicks, mousebutton, modifiers)
    execute 'silent !tmux select-window -t ' . a:idx
  endfunction
]])

return M
