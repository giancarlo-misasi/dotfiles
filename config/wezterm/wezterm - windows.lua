local wezterm = require 'wezterm'
local action = wezterm.action
local mux = wezterm.mux
local config = {}

-- Appearance
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.color_scheme = 'One Dark (Gogh)'
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 13.0

-- Domains
config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = 'Ubuntu',
    default_cwd = '~'
  },
}

-- Keybindings
config.disable_default_key_bindings = true
config.keys = {
  { key = 'C', mods = 'SHIFT|CTRL', action = action.CopyTo 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = action.PasteFrom 'Clipboard' },
  { key = 'F', mods = 'SHIFT|CTRL', action = action.Search 'CurrentSelectionOrEmptyString' },
  { key = 'P', mods = 'SHIFT|CTRL', action = action.ActivateCommandPalette },
  { key = 'L', mods = 'SHIFT|CTRL', action = action.ShowLauncher },
  { key = 'T', mods = 'SHIFT|CTRL', action = action.SpawnTab 'CurrentPaneDomain' },
  { key = 'N', mods = 'SHIFT|CTRL', action = action.SpawnWindow },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'DownArrow',  mods = 'SHIFT|CTRL', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'LeftArrow',  mods = 'ALT|SHIFT', action = action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = action.ActivateTabRelative( 1) },
  { key = 'LeftArrow',  mods = 'ALT|CTRL', action = action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT|CTRL', action = action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT|CTRL', action = action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT|CTRL', action = action.ActivatePaneDirection 'Down' },
}

-- Startup
config.default_domain = 'WSL:Ubuntu'

return config