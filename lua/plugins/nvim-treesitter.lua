return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,            -- no soporta lazy loading
  build = ":TSUpdate",
  opts = {
    -- dónde instalar parsers/queries (da prioridad en rtp)
    install_dir = vim.fn.stdpath("data") .. "/site",
    ensure_installed = {
      "lua", "python", "javascript", "typescript", "rust",
      "c", "cpp", "bash", "json", "yaml", "toml",
      "html", "css", "markdown", "markdown_inline",
      "cmake", "java",
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  config = function(_, opts)
    -- API nueva del rewrite
    require("nvim-treesitter").setup(opts)
  end,
}
