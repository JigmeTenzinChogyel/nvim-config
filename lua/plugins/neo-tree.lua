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

        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
            highlight = "NeoTreeFileIcon",
          },
        },

        window = {
          position = "left",
          width = 40,
          mappings = {
            ["<space>"] = "none",
            ["l"] = "open",
            ["h"] = "close_node",
            ["<cr>"] = "open",
            ["o"] = "open",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
          },
        },

        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  },
}
