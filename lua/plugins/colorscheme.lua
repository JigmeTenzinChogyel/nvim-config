return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- mocha, latte, frappe, macchiato
      term_colors = true,
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
