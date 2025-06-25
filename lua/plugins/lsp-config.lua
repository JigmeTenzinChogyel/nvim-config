return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "gopls" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			-- 🧠 Attach LSP keymaps only when a server attaches
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap.set

				keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Info" }))
				keymap("n", "gd", function()
					vim.cmd("vsplit")
					vim.lsp.buf.definition()
				end, vim.tbl_extend("force", opts, { desc = "Go to Definition (Vertical Split)" }))
				keymap(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code Action" })
				)
			end

			-- 🧪 Setup servers
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- ✅ Show diagnostics inline
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			})

			-- 💡 Optional: diagnostics in floating window on hover
			vim.o.updatetime = 250
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						border = "rounded",
						source = "always",
						prefix = "",
						scope = "cursor",
					})
				end,
			})
		end,
	},
}
