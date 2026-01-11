return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      cmake = { "cmake_format" },
      python = { "ruff_format" },  -- ruff_format maneja formateo e imports
      lua = { "stylua" },
    },
    -- format_on_save se maneja via autocmd en autocmds.lua
    format_on_save = nil,
  },
}
