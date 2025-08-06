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

-- Essential keybindings
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>W', ':wa<CR>', { desc = "Save all files" })
vim.keymap.set('n', '<leader>x', ':x<CR>', { desc = "Save and quit" })

-- Window splits
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = "Split window vertically" })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = "Split window horizontally" })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = "Make splits equal size" })
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = "Close current split" })

-- Window navigation (alternative to tmux nav)
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = "Go to left window" })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = "Go to bottom window" })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = "Go to top window" })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = "Go to right window" })

-- Tab management
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = "Open new tab" })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = "Close current tab" })
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = "Go to next tab" })
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = "Go to previous tab" })
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = "Open current buffer in new tab" })

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = "Resize window up" })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = "Resize window down" })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = "Resize window left" })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = "Resize window right" })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = "Indent left and keep selection" })
vim.keymap.set('v', '>', '>gv', { desc = "Indent right and keep selection" })

-- Move text up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = "Move line down" })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = "Move line up" })

-- Clear search highlights
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = "Clear search highlights" })

-- Quick quit
vim.keymap.set('n', '<leader>qq', ':qa<CR>', { desc = "Quit all" })
vim.keymap.set('n', '<leader>qQ', ':qa!<CR>', { desc = "Force quit all" })

-- Configure persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undo')
vim.fn.mkdir(vim.fn.expand('~/.config/nvim/undo'), 'p')

-- Better swap and backup file locations
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand('~/.config/nvim/swap')
vim.fn.mkdir(vim.fn.expand('~/.config/nvim/swap'), 'p')
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand('~/.config/nvim/backup')
vim.fn.mkdir(vim.fn.expand('~/.config/nvim/backup'), 'p')

-- Auto-commands for workflow optimization
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Format on save (only for supported file types)
local format_on_save = augroup('FormatOnSave', { clear = true })
autocmd('BufWritePre', {
  group = format_on_save,
  pattern = { '*.lua', '*.js', '*.ts', '*.jsx', '*.tsx', '*.go', '*.py', '*.rs' },
  callback = function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Highlight on yank
local highlight_yank = augroup('HighlightYank', { clear = true })
autocmd('TextYankPost', {
  group = highlight_yank,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

-- Auto-close brackets and quotes
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Remove trailing whitespace on save
local trim_whitespace = augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = trim_whitespace,
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[:silent! %s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

-- Auto-resize splits when window is resized
local resize_splits = augroup('ResizeSplits', { clear = true })
autocmd('VimResized', {
  group = resize_splits,
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Remember last cursor position
local remember_cursor = augroup('RememberCursor', { clear = true })
autocmd('BufReadPost', {
  group = remember_cursor,
  callback = function()
    local line = vim.fn.line([["]])
    if line > 1 and line <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})

-- 🔧 THIS WAS MISSING — it actually starts Lazy.nvimtools
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})


