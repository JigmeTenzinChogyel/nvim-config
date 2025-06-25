local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true           -- Show absolute line numbers
vim.opt.relativenumber = false   -- Show relative line numbers (optional)

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Navigate buffers
vim.keymap.set('n', '<leader>l', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>h', ':bprevious<CR>', { desc = "Previous buffer" })

-- Delete (close) buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = "Delete current buffer" })

-- Force delete buffer (if it's stubborn)
vim.keymap.set('n', '<leader>Q', ':bd!<CR>', { desc = "Force delete buffer" })

-- List buffers (optional if using Telescope)
vim.keymap.set('n', '<leader>bb', ':ls<CR>:b<Space>', { desc = "List and switch buffers" })

-- 🔧 THIS WAS MISSING — it actually starts Lazy.nvimtools
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})


