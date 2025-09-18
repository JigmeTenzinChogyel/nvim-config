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
				ensure_installed = { "lua_ls", "ts_ls", "gopls", "pyright", "rust_analyzer" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 🧠 Attach LSP keymaps only when a server attaches
			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				local keymap = vim.keymap.set

				keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Info" }))
				keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
				keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Telescope Go to Definition" })
				keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Telescope References" })
				keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Telescope Implementations" })
				keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
				keymap(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code Action" })
				)
				keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
				keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
				keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open Diagnostic Float" }))
			end

			-- 🧪 Setup servers using vim.lsp.config
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
				root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			}

			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.mod", ".git", "go.work" },
				capabilities = capabilities,
				on_attach = on_attach,
			}

			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
				capabilities = capabilities,
				on_attach = on_attach,
			}

			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				filetypes = { "rust" },
				root_markers = { "Cargo.toml", "rust-project.json" },
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			}

			-- ✅ Show diagnostics inline
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
					source = "if_many",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
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
