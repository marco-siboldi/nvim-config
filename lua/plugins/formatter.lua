return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    -- Definir formateadores por filetype
    formatters_by_ft = {
      -- C/C++
      c = { "clang-format" },
      cpp = { "clang-format" },
      
      -- Python: puedes elegir ruff o black+isort
      -- Opción 1: ruff (más rápido, todo en uno)
      python = { "ruff_format", "ruff_organize_imports" },
      -- Opción 2: black + isort (descomenta si prefieres esto)
      -- python = { "isort", "black" },
      
      -- Lua
      lua = { "stylua" },
      
      -- Otros lenguajes comunes
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      
      -- CMake
      cmake = { "cmake_format" },
    },
    
    -- Formatear al guardar (esto se puede deshabilitar si se prefiere manual)
    format_on_save = function(bufnr)
      -- Deshabilita autoformat en ciertos filetypes si es necesario
      local disable_filetypes = { }
      local filetype = vim.bo[bufnr].filetype
      if vim.tbl_contains(disable_filetypes, filetype) then
        return
      end
      
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
    
    -- Configuración de formateadores específicos
    formatters = {
      -- Ejemplo: personalizar clang-format
      ["clang-format"] = {
        prepend_args = { "--style=llvm" }, -- Puedes cambiar el estilo aquí
      },
      -- Ejemplo: personalizar stylua
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
    },
  },
  
  -- Comandos útiles
  init = function()
    -- Comando manual para formatear
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true, desc = "Formatear código con conform.nvim" })
  end,
}
