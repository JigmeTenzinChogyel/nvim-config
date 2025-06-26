return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = { "lua", "go", "javascript", "typescript", "html", "tsx", "vue" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        per_filetype = {
          html = {
            enable_close = false, -- example override
          },
        },
      })
    end,
  },
}

