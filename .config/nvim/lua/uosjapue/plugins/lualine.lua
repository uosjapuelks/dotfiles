-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine kanagawa theme
local lualine_kanagawa = require("lualine.themes.kanagawa")

-- new colors for theme
local new_colors = {
  blue = "#65D1FF",
  green = "#3EFFDC",
  violet = "#FF61EF",
  yellow = "#FFDA7B",
  black = "#000000",
}

-- change nightlfy theme colors
lualine_kanagawa.normal.a.bg = new_colors.blue
lualine_kanagawa.insert.a.bg = new_colors.green
lualine_kanagawa.visual.a.bg = new_colors.violet
lualine_kanagawa.command = {
  a = {
    gui = "bold",
    bg = new_colors.yellow,
    fg = new_colors.black, -- black
  },
}

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_kanagawa,
  },
})
