return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- optional image preview
  },
  lazy = false, -- load immediately
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- closes Neo-tree if it's the last window
      popup_border_style = "rounded", -- or "single", "double", "solid"
      enable_git_status = true,
      enable_diagnostics = true,

      window = {
        position = "left", -- "left", "right", "top", "bottom"
        width = 30,
        mappings = {
          ["<space>"] = "none", -- disable space key
          ["l"] = "open", -- open file or expand directory
          ["h"] = "close_node", -- collapse directory
          ["<cr>"] = "open",
          ["o"] = "open",
        },
      },

      filesystem = {
        filtered_items = {
          visible = false, -- show filtered items in the tree
          hide_dotfiles = true,
          hide_gitignored = true,
        },
      },
    })
  end,
}

