return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = {
			preset = "super-tab",       -- Tab navega/expande/confirma, Shift-Tab va atrás
			["<CR>"] = { "accept", "fallback" }, -- Enter confirma si hay item
			["<C-Space>"] = { "show", "show_documentation" },
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			list = { selection = { preselect = true, auto_insert = true } },
			documentation = { auto_show = true },
		},
		snippets = {
			preset = "luasnip", -- usa LuaSnip para expandir
		},
		sources = {
			default = { "lsp", "path", "buffer", "snippets" },
		},
	},
}
