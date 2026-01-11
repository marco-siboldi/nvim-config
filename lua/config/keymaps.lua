local map = vim.keymap.set

-- Bufferline
map("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Buffer siguiente" })
map("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Buffer anterior" })
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true, desc = "Ir al buffer 1" })
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true, desc = "Ir al buffer 2" })
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true, desc = "Ir al buffer 3" })
map("n", "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", { silent = true, desc = "Ir al último buffer visible" })
map("n", "<leader>p", "<Cmd>BufferLinePick<CR>", { silent = true, desc = "Picker de buffers" })
map("n", "<leader>P", "<Cmd>BufferLinePickClose<CR>", { silent = true, desc = "Cerrar con picker" })
map("n", "<leader>c", "<Cmd>BufferLineCloseOthers<CR>", { silent = true, desc = "Cerrar otros buffers" })
map("n", "<leader>]", "<Cmd>BufferLineMoveNext<CR>", { silent = true, desc = "Mover buffer a la derecha" })
map("n", "<leader>[", "<Cmd>BufferLineMovePrev<CR>", { silent = true, desc = "Mover buffer a la izquierda" })
map("n", "<leader>q", "<Cmd>bdelete<CR>", { silent = true, desc = "Cerrar buffer actual" })
map("n", "<leader>z", "<Cmd>BufferLineTogglePin<CR>", { silent = true, desc = "Pinear/despinear buffer" })

-- LSP
map("n", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP Hover" })
map("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "Ir a definición" })
map("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Ir a declaración" })
map("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "Ir a implementación" })
map("n", "gr", vim.lsp.buf.references, { silent = true, desc = "Referencias" })
map("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, desc = "Renombrar símbolo" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Code action" })
map("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Diag anterior" })
map("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Diag siguiente" })
map("n", "<leader>ld", vim.diagnostic.open_float, { silent = true, desc = "Diag flotante" }) -- cambié de <leader>e a <leader>ld
map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { silent = true, desc = "Formatear" })
