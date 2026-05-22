-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight_ms",
  theme_toggle = { "tokyonight_ms", "one_light" },

  hl_override = {
    Comment      = { italic = true },
    ["@comment"] = { italic = true },
  },

  hl_add = {
    FloatBorder                = { fg = "nord_blue", bg = "darker_black" },
    DiagnosticVirtualTextError = { fg = "red",    italic = true },
    DiagnosticVirtualTextWarn  = { fg = "yellow", italic = true },
    DiagnosticVirtualTextInfo  = { fg = "blue",   italic = true },
    DiagnosticVirtualTextHint  = { fg = "teal",   italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = { lazyload = false },
}

return M
