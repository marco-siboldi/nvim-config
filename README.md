# nvim-config

My personal Neovim configuration, focused on a fast Lua-first setup.

## Quick start

```bash
# Back up any existing config
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)

# Clone this config
git clone https://github.com/marco-siboldi/nvim-config ~/.config/nvim

# Start Neovim (first run installs plugins)
nvim
```

> Tip: run `:checkhealth` after the first launch to verify dependencies.

## Requirements

- Neovim >= 0.9 (0.10+ recommended)
- Git
- A Nerd Font (for icons)
- ripgrep (`rg`) and fd (`fd`) for fuzzy finding (optional but recommended)
- Node.js / Python / Go (only if you use language servers or tooling that need them)

## Features (adjust to match your config)

- Plugin manager: (e.g., `lazy.nvim`)
- LSP + formatting + linting (e.g., `nvim-lspconfig`, `mason.nvim`, `null-ls`/`conform`)
- Completion and snippets (e.g., `nvim-cmp`, `LuaSnip`)
- Treesitter syntax highlighting
- Telescope fuzzy finding
- File explorer (e.g., `nvim-tree` or `oil`)
- Statusline / bufferline (e.g., `lualine`, `bufferline`)
- Git integration (e.g., `gitsigns`)
- Colorscheme (list yours)

## Keymaps (examples—replace with your actual bindings)

- `<leader>ff` — Find files
- `<leader>fg` — Live grep
- `<leader>fb` — Buffers
- `<leader>e`  — Toggle file explorer
- `gd` / `gr` — Go to definition / references
- `<leader>rn` — Rename symbol
- `<leader>ca` — Code action
- `[d` / `]d` — Prev/next diagnostic
- `<leader>f` — Format buffer

## Structure

```
lua/
  <your modules>
init.lua            # main entry point (or use init.vim)
```

Add any screenshots or notes about themes, fonts, or shells here.

## Updating

```bash
cd ~/.config/nvim
git pull
nvim --headless "+Lazy! sync" +qa  # adjust if you use a different manager
```

## Troubleshooting

- Run `:checkhealth`
- Clear and reinstall plugins if needed (e.g., remove `~/.local/share/nvim/lazy` or your plugin dir, then restart)
- Check `:messages` for errors
