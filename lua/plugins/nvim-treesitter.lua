return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      auto_install = true,
      ensure_installed = { "lua", "go", "javascript", "typescript" }, -- languages to install
      highlight = { enable = true },   -- enable syntax highlighting
      indent = { enable = true },      -- enable indentation based on treesitter
      incremental_selection = { enable = true },
      -- add more features here as needed
    })
  end,
}

