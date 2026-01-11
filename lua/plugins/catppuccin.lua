return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- carga antes de otros plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        bufferline = { enabled = true }, -- << habilita integración bufferline
        treesitter = true,
        telescope = true,
        cmp = true,
        gitsigns = true,
        lsp_trouble = true,
        nvimtree = true,
        mason = true,
      },
      -- “portena_milonga”
      color_overrides = {
        mocha = {
          base = "#2f241d",
          mantle = "#261c17",
          crust = "#1c1410",
          surface0 = "#3c3027",
          surface1 = "#4a3c31",
          surface2 = "#5c4b3c",
          text = "#e8e0d6",
          subtext1 = "#d6c8ba",
          subtext0 = "#c3b4a5",
          overlay2 = "#a79486",
          overlay1 = "#907d71",
          overlay0 = "#7c6a5f",
          lavender = "#b7b1c5",
          blue = "#36516b",
          sapphire = "#3b5f82",
          sky = "#7ca5c9",
          teal = "#4f7d76",
          green = "#6b8c74",
          yellow = "#c9a24c",
          peach = "#e6a06a",
          maroon = "#7a2f2a",
          red = "#b7433f",
          mauve = "#9e7c9a",
          pink = "#d8b1b9",
          flamingo = "#d4a59a",
          rosewater = "#f3d8c4",
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
