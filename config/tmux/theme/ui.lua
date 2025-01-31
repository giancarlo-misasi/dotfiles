local M = {}
local colors = require("theme.colors")
local icons = require("theme.icons")

local function color(bgc, fgc)
  return "#[bg=" .. bgc .. ",fg=" .. fgc .. "]"
end

local function range(name, content)
  return "#[range=user|" .. name .. "]" .. content ..
      "" -- "#[norange]"
end

local function buttons()
  return
      range("split_right", icons.split_right) ..
      range("split_down", icons.split_down) ..
      range("add_window", icons.new_window) ..
      ""
end

M.left_status = function()
  return
      color(colors.bg, colors.dim) ..
      range("commands_menu", icons.tmux) ..
      range("sessions_menu", "[ #S ]") ..
      ""
end

M.current_window = function()
  return
      color(colors.bg, colors.dim) ..
      "#{?#{==:#I,1}," ..
      buttons() ..
      ",}" ..
      color(colors.bg, colors.fg) ..
      " #I " ..
      ""
end

M.windows = function()
  return
      color(colors.bg, colors.dim) ..
      "#{?#{==:#I,1}," ..
      buttons() ..
      range("first_window", " #I ") ..
      ",}" ..
      color(colors.bg, colors.dim) ..
      "#{?#{>:#I,1}, #I ,}" ..
      ""
end

M.right_status = function()
  return
      color(colors.bg, colors.close) ..
      icons.l_triangle ..
      color(colors.close, colors.fg) ..
      range("close_window", icons.close) ..
      ""
end

return M
