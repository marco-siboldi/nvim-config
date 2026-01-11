return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- para capacidades mejoradas de completado
  },
  config = function()
    -- Init mason
    pcall(require, "mason")
    pcall(require, "mason-lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    end)

    -- on_attach: keymaps buffer-local cuando se adjunta un LSP
    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Keymaps específicos del buffer
      map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
      map("n", "gd", vim.lsp.buf.definition, "LSP: Ir a definición")
      map("n", "gD", vim.lsp.buf.declaration, "LSP: Ir a declaración")
      map("n", "gi", vim.lsp.buf.implementation, "LSP: Ir a implementación")
      map("n", "gr", vim.lsp.buf.references, "LSP: Referencias")
      map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Renombrar")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
      map("n", "[d", vim.diagnostic.goto_prev, "LSP: Diagnóstico anterior")
      map("n", "]d", vim.diagnostic.goto_next, "LSP: Diagnóstico siguiente")
      map("n", "<leader>ld", vim.diagnostic.open_float, "LSP: Diagnóstico flotante")
      map("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "LSP: Formatear")
    end

    -- clangd: autostart por FileType usando vim.lsp.start (sin warning)
    local clangd_cfg = {
      name = "clangd",
      cmd = { "clangd", "--background-index", "--fallback-style=llvm" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      capabilities = capabilities,
      on_attach = on_attach,
      single_file_support = true,
      root_dir = function(fname)
        return vim.fs.root(fname, {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git",
        }) or vim.fs.dirname(fname) or vim.loop.cwd()
      end,
    }

    local aug = vim.api.nvim_create_augroup("clangd_lsp", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = aug,
      pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
      callback = function(args)
        -- evita duplicar
        if not vim.lsp.get_clients({ bufnr = args.buf, name = "clangd" })[1] then
          vim.lsp.start(clangd_cfg)
        end
      end,
    })

    -- Resto de servidores con API nueva
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config("bashls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- CMake Language Server
    vim.lsp.config("cmake", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Java (jdtls): se configurará manualmente con nvim-jdtls en el futuro
    -- Por ahora preparamos la entrada en mason, pero sin vim.lsp.enable
    -- para que no se inicie automáticamente hasta tener config específica

    vim.lsp.enable("lua_ls")
    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("bashls")
    vim.lsp.enable("jsonls")
    vim.lsp.enable("yamlls")
    vim.lsp.enable("cmake")
  end,
}
