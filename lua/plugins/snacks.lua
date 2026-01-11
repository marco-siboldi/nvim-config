return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      enabled = true,
      hidden = true, -- inicia mostrando dotfiles
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      -- atajos dentro del explorer
      mappings = {
        ["H"] = "toggle_hidden", -- H para alternar ocultos
      },
    },
    picker = { enabled = true },
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,",      function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/",      function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:",      function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n",      function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- abre el explorer en ~/.config con ocultos
    { "<leader>e",      function() Snacks.explorer({ dir = "~/.config", hidden = true }) end, desc = "File Explorer" },
  },
}
