vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

vim.cmd("runtime macros/matchit.vim")

-- Activar el resaltado de sintaxis
vim.cmd('syntax on')

-- Activar detección de tipo de archivo y sangría automática
vim.cmd('filetype plugin indent on')

-- Habilitar colores reales (24-bit) si tu terminal lo soporta
vim.opt.termguicolors = true
require("bufferline").setup{}
-- Elegir un esquema de colores (puedes cambiar 'habamax' por 'desert' o 'industry')
-- vim.cmd('colorscheme moccha')

-- Mantener 8 líneas de margen al hacer scroll (el extra que te dije)
vim.opt.scrolloff = 0 

-- Mostrar números de línea
vim.opt.number = true

-- ==========================================
-- ATAJOS PARA DOCENCIA / PROGRAMACIÓN EN C
-- ==========================================

-- Al presionar F5 en un archivo .c:
-- 1. Guarda el archivo (:w)
-- 2. Compila con gcc
-- 3. Si compila bien, lo ejecuta
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    -- Mapeo en modo normal para F5
    vim.keymap.set(
      "n", 
      "<F5>", 
      ":w <bar> !gcc % -o %< && ./%< <CR>", 
      { buffer = true, silent = true }
    )
  end,
})
