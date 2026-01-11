return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- quitamos cmp-nvim-lsp porque ahora usamos blink.cmp
	},
	config = function()
		-- Init mason
		pcall(require, "mason")
		pcall(require, "mason-lspconfig")

		-- Obtener on_attach de keymaps.lua
		local keymaps = require("config.keymaps")
		local on_attach = keymaps.lsp_on_attach

		-- Capacidades desde blink.cmp (fallback a capabilities base si falla)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok_blink, blink = pcall(require, "blink.cmp")
		if ok_blink and blink.get_lsp_capabilities then
			capabilities = blink.get_lsp_capabilities(capabilities)
		end

		-- clangd: autostart por FileType usando vim.lsp.start (sin warning)
		local clangd_cfg = {
			name = "clangd",
			cmd = { "clangd", "--background-index", "--fallback-style=llvm" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			capabilities = capabilities,
			on_attach = on_attach,
			single_file_support = true,
			root_dir = function(fname)
				return vim.fs.root(fname, {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				}) or vim.fs.dirname(fname) or vim.loop.cwd()
			end,
		}

		local aug = vim.api.nvim_create_augroup("clangd_lsp", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = aug,
			pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
			callback = function(args)
				-- evita duplicar
				if not vim.lsp.get_clients({ bufnr = args.buf, name = "clangd" })[1] then
					vim.lsp.start(clangd_cfg)
				end
			end,
		})

		-- Resto de servidores con API nueva
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		})
		vim.lsp.config("pyright", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("ts_ls", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("rust_analyzer", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("bashls", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("jsonls", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("yamlls", { capabilities = capabilities, on_attach = on_attach })
		vim.lsp.config("neocmake", { capabilities = capabilities, on_attach = on_attach })
		-- Preparación para jdtls (se configurará manualmente después)

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("bashls")
		vim.lsp.enable("jsonls")
		vim.lsp.enable("yamlls")
		vim.lsp.enable("neocmake")
	end,
}
