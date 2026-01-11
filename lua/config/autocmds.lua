-- Autocmds para formateo, highlight de yank, limpieza de espacios, etc.

local aug_format = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug_format,
  pattern = "*",
  callback = function(args)
    -- Intentar formatear con conform.nvim si está disponible
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ bufnr = args.buf, timeout_ms = 1000, lsp_fallback = true })
    else
      -- Fallback a LSP format si conform no está
      vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 1000 })
    end
  end,
})

-- Highlight al copiar
local aug_yank = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug_yank,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Limpiar espacios al final de línea en archivos de código
local aug_trim = vim.api.nvim_create_augroup("TrimTrailingSpaces", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug_trim,
  pattern = { "*.lua", "*.c", "*.cpp", "*.py", "*.js", "*.ts", "*.rs", "*.java", "*.go", "*.cmake" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
