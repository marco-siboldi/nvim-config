require "nvchad.autocmds"

-- NvimTree: panel ligeramente más oscuro que el editor
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    local hl = vim.api.nvim_set_hl
    hl(0, "NvimTreeNormal",       { bg = "#1e1e1e" })
    hl(0, "NvimTreeNormalNC",     { bg = "#1e1e1e" })
    hl(0, "NvimTreeWinSeparator", { fg = "#555555", bg = "#1e1e1e" })
    hl(0, "NvimTreeEndOfBuffer",  { fg = "#1e1e1e", bg = "#1e1e1e" })
    hl(0, "NvimTreeStatusLine",   { bg = "#1e1e1e" })
    hl(0, "NvimTreeStatusLineNC", { bg = "#1e1e1e" })
  end,
})
