return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "lua_ls",
          "pyright",
          "ts_ls",        -- typescript-language-server
          "rust_analyzer",
          "bashls",
          "jsonls",
          "yamlls",
          "neocmake",     -- cmake language server
          "jdtls",
        },
        automatic_installation = true,
      })
    end,
  },
}
