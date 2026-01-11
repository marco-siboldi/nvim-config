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

-- LSP: keymaps buffer-local vía LspAttach
local function lsp_on_attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP Hover" }))
  map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Ir a definición" }))
  map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Ir a declaración" }))
  map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Ir a implementación" }))
  map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Referencias" }))
  map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Renombrar símbolo" }))
  map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diag anterior" }))
  map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diag siguiente" }))
  map("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diag flotante" }))
  map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Formatear" }))
end

-- Autocmd para aplicar keymaps LSP cuando se adjunta un servidor
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      lsp_on_attach(client, bufnr)
    end
  end,
})

-- DAP (debugger)
map("n", "<F9>", function() require("dap").toggle_breakpoint() end, { silent = true, desc = "DAP: Toggle breakpoint" })
map("n", "<F10>", function() require("dap").step_over() end, { silent = true, desc = "DAP: Step over" })
map("n", "<F11>", function() require("dap").step_into() end, { silent = true, desc = "DAP: Step into" })
map("n", "<F12>", function() require("dap").step_out() end, { silent = true, desc = "DAP: Step out" })
map("n", "<leader>dc", function() require("dap").continue() end, { silent = true, desc = "DAP: Continue" })
map("n", "<leader>dt", function() require("dap").terminate() end, { silent = true, desc = "DAP: Terminate" })
map("n", "<leader>du", function() require("dapui").toggle() end, { silent = true, desc = "DAP: Toggle UI" })

-- Exportar helper para reusar en lsp.lua
return {
  lsp_on_attach = lsp_on_attach,
}
