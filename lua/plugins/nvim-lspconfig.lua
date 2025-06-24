return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({})
    lspconfig.ts_ls.setup({})


    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Displays hover information" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
  end

}
