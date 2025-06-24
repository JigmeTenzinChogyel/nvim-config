return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- enable Treesitter integration
      fast_wrap = {},  -- optional: fast wrap with <M-e> by default
    })
  end,
}

