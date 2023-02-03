local name = 'colors'
local utils = require('utils').start_script(name)

local M = {
    white = "#c1c1c1",
    black = "#101012",
    bg0 = "#232326",
    bg1 = "#2c2d31",
    bg2 = "#35363b",
    bg3 = "#37383d",
    bg_d = "#1b1c1e",
    bg_blue = "#68aee8",
    bg_yellow = "#e2c792",
    fg = "#a7aab0",
    purple = "#bb70d2",
    green = "#8fb573",
    orange = "#c49060",
    blue = "#57a5e5",
    yellow = "#dbb671",
    cyan = "#51a8b3",
    red = "#de5d68",
    grey = "#5a5b5e",
    light_grey = "#818387",
    gray1  = '#828997',
    gray2  = '#2c323c',
    gray3  = '#3e4452',
    dark_cyan = "#2b5d63",
    dark_red = "#833b3b",
    dark_yellow = "#7c5c20",
    dark_purple = "#79428a",
    diff_add = "#282b26",
    diff_delete = "#2a2626",
    diff_change = "#1a2a37",
    diff_text = "#2c485f",
}

utils.end_script(name)
return M