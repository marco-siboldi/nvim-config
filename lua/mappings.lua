require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- CMake (<leader>c)
map("n", "<leader>cg", "<cmd>CMakeGenerate<cr>",         { desc = "CMake Generate" })
map("n", "<leader>cb", "<cmd>CMakeBuild<cr>",             { desc = "CMake Build" })
map("n", "<leader>cr", "<cmd>CMakeRun<cr>",               { desc = "CMake Run target" })
map("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select target" })
map("n", "<leader>cd", "<cmd>CMakeSelectBuildType<cr>",   { desc = "CMake Build type" })
map("n", "<leader>cx", "<cmd>CMakeClean<cr>",             { desc = "CMake Clean" })
map("n", "<leader>cs", "<cmd>CMakeStop<cr>",              { desc = "CMake Stop" })
