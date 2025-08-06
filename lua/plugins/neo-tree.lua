return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>n", ":Neotree focus<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>r", ":Neotree reveal<CR>", { noremap = true, silent = true })

			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,

				window = {
					position = "float",
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					-- width = 40,
					mappings = {
						["l"] = "open",
						["h"] = "close_node",
						-- ["<cr>"] = "open",
						-- ["<space>"] = "none",
						-- ["o"] = "open",
						-- ["s"] = "open_split",
						-- ["v"] = "open_vsplit",
						-- ["t"] = "open_tabnew",
					},
				},

				default_component_configs = {
					indent = {
						indent_size = 2,
						padding = 1,
						with_markers = true,
						markers = {
							corner = "└",
							edge = "│",
							item = "├",
							none = " ",
						},
						with_expanders = true,
						expanders = {
							collapsed = "▶",
							expanded = "▼",
							remote_collapsed = "▷",
							remote_expanded = "▽",
						},
					},

					git_status = {
						symbols = {
							added = "",
							modified = "",
							deleted = "",
							renamed = "",
							untracked = "",
							ignored = "",
							unstaged = "",
							staged = "",
							conflict = "",
						},
						align = "right",
						color_icons = true,
					},

					diagnostics = {
						symbols = {
							error = "", -- nf-cod-error
							warning = "", -- nf-cod-warning
							info = "", -- nf-cod-info
							hint = "", -- nf-cod-light_bulb
						},
						highlight = {
							error = "DiagnosticError",
							warning = "DiagnosticWarn",
							info = "DiagnosticInfo",
							hint = "DiagnosticHint",
						},
						severity = {
							min = vim.diagnostic.severity.HINT,
							max = vim.diagnostic.severity.ERROR,
						},
					},

					icon = {
						folder_closed = "", -- nf-cod-folder
						folder_open = "", -- nf-cod-folder_opened
						folder_empty = "", -- use same icon but detect empty separately
						default = "", -- nf-cod-file
						symlink = "", -- unchanged, still the best
					},

					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						max_length = 40,
					},
				},

				filesystem = {
					follow_current_file = {
						enabled = true,
						-- leave_dirs_open = false,
					},
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})
		end,
	},
}
