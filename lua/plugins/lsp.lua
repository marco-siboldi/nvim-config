return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Init mason
    pcall(require, "mason")
    pcall(require, "mason-lspconfig")

    -- Obtener on_attach de keymaps.lua
    local keymaps = require("config.keymaps")
    local on_attach = keymaps.lsp_on_attach

    -- Capacidades mejoradas de nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    end)

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
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })
    vim.lsp.config("pyright", { capabilities = capabilities })
    vim.lsp.config("ts_ls", { capabilities = capabilities })
    vim.lsp.config("rust_analyzer", { capabilities = capabilities })
    vim.lsp.config("bashls", { capabilities = capabilities })
    vim.lsp.config("jsonls", { capabilities = capabilities })
    vim.lsp.config("yamlls", { capabilities = capabilities })
    vim.lsp.config("cmake", { capabilities = capabilities })
    -- Preparación para jdtls (se configurará manualmente después)

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
