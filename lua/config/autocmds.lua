-- Autocomandos personalizados

-- Grupo para resaltar yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  desc = "Resalta brevemente el texto copiado",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Grupo para limpieza de trailing spaces al guardar
local trailing_group = vim.api.nvim_create_augroup("TrailingSpaceCleanup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = trailing_group,
  pattern = "*",
  desc = "Elimina espacios en blanco al final de líneas al guardar",
  callback = function()
    -- Guarda la posición del cursor
    local save_cursor = vim.fn.getpos(".")
    -- Elimina trailing spaces
    vim.cmd([[%s/\s\+$//e]])
    -- Restaura la posición del cursor
    vim.fn.setpos(".", save_cursor)
  end,
})

