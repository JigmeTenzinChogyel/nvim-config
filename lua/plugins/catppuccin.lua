return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- Optional: configure the colorscheme here, e.g.:
      require("catppuccin").setup()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}


