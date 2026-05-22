-- Tokyo Night MS — custom theme for NvChad
-- Fondo sincronizado con Kitty terminal (#2c2c2c)
-- Acentos Tokyo Night: #769ff0 · #a3aed2 · #394260

local M = {}

M.base_30 = {
  white          = "#dcdcdc",   -- fg igual que kitty
  darker_black   = "#1e1e1e",   -- más oscuro que kitty bg
  black          = "#2c2c2c",   -- kitty bg exacto
  black2         = "#333333",
  one_bg         = "#3a3a3a",
  one_bg2        = "#424242",
  one_bg3        = "#4a4a4a",
  grey           = "#555555",   -- separadores neutros
  grey_fg        = "#707070",
  grey_fg2       = "#606060",
  light_grey     = "#a3aed2",   -- Tokyo Night secondary (fastfetch)
  red            = "#f7768e",   -- Tokyo Night red
  baby_pink      = "#de8c92",
  pink           = "#ff75a0",
  line           = "#3f3f3f",   -- divisores
  green          = "#9ece6a",   -- Tokyo Night green
  vibrant_green  = "#73daca",   -- Tokyo Night teal
  nord_blue      = "#769ff0",   -- acento principal (fastfetch)
  blue           = "#769ff0",
  yellow         = "#e0af68",   -- Tokyo Night yellow
  sun            = "#ff9e64",   -- Tokyo Night orange
  purple         = "#bb9af7",   -- Tokyo Night purple
  dark_purple    = "#9d7cd8",
  teal           = "#7dcfff",   -- Tokyo Night cyan
  orange         = "#ff9e64",
  cyan           = "#7dcfff",
  statusline_bg  = "#252525",
  lightbg        = "#3f3f3f",
  pmenu_bg       = "#769ff0",
  folder_bg      = "#769ff0",
}

M.base_16 = {
  base00 = "#2c2c2c",   -- nvim bg = kitty bg
  base01 = "#1e1e1e",   -- lighter bg (gutters, etc)
  base02 = "#3f3f3f",   -- selection bg
  base03 = "#606060",   -- comments
  base04 = "#a3aed2",   -- dark fg (Tokyo Night secondary)
  base05 = "#dcdcdc",   -- default fg = kitty fg
  base06 = "#e0e0e0",
  base07 = "#f0f0f0",
  base08 = "#73daca",   -- variables (Tokyo Night teal)
  base09 = "#ff9e64",   -- integers, constants
  base0A = "#0db9d7",   -- classes
  base0B = "#9ece6a",   -- strings
  base0C = "#b4f9f8",   -- support
  base0D = "#769ff0",   -- functions (acento fastfetch)
  base0E = "#bb9af7",   -- keywords
  base0F = "#f7768e",   -- errors
}

M.polish_hl = {
  treesitter = {
    ["@variable"]              = { fg = M.base_16.base05 },
    ["@variable.parameter"]    = { fg = M.base_30.orange },
    ["@function.call"]         = { fg = M.base_30.blue },
    ["@function.method.call"]  = { fg = M.base_30.blue },
    ["@constant"]              = { fg = M.base_30.orange },
    ["@punctuation.bracket"]   = { fg = M.base_30.purple },
    ["@comment"]               = { fg = M.base_30.grey, italic = true },
  },
  syntax = {
    Comment = { fg = M.base_30.grey, italic = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "tokyonight_ms")

return M
