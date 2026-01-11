return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "catppuccin/nvim", name = "catppuccin" },
  },
  event = "VeryLazy",
  config = function()
    vim.opt.termguicolors = true

    -- Usa highlights de Catppuccin si está disponible; si no, fallback vacío
    local ok, ctp = pcall(require, "catppuccin.groups.integrations.bufferline")
    local highlights = ok and ctp.get() or {}

    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.minimal,
        separator_style = "slant",
        themable = true,
        numbers = "none",
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return icon .. count
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        always_show_bufferline = true,
        truncate_names = true,
        max_name_length = 22,
        offsets = {
          { filetype = "snacks_explorer", text = "Explorer", highlight = "Directory", separator = true },
          { filetype = "neo-tree",        text = "File Explorer", highlight = "Directory", separator = true },
        },
        hover = { enabled = true, delay = 120, reveal = { "close" } },
        sort_by = "relative_directory",
        pick = { alphabet = "asdfjkl;ghuiopqwertyZXCVBNM1234567890" },
      },
      highlights = highlights,
    })
  end,
}
