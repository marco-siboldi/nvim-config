return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "c", "cpp", "python", "cmake",
      },
    },
  },

  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      cmake_build_directory = "build/${variant:buildType}",
      cmake_build_directory_prefix = "linux-",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
      cmake_executor = {
        name = "terminal",
        opts = { split_direction = "horizontal", split_size = 11 },
      },
      cmake_runner = {
        name = "terminal",
        opts = { split_direction = "horizontal", split_size = 11 },
      },
    },
  },
}
