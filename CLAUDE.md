# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built with the Lazy.nvim plugin manager. The configuration is modular with plugins organized in separate files.

## Architecture

- **Entry Point**: `init.lua` loads the lazy plugin manager configuration
- **Plugin Manager**: Uses Lazy.nvim (`lua/config/lazy.lua`) to manage plugins
- **Plugin Organization**: Individual plugins are configured in `lua/plugins/` directory
- **Configuration Structure**:
  - `init.lua` → `lua/config/lazy.lua` → `lua/plugins/*.lua`
  - Each plugin file returns a table with plugin specifications

## Key Configuration Files

### Core Configuration (`lua/config/lazy.lua`)
- Sets up Lazy.nvim plugin manager
- Configures basic Vim options (tabs, line numbers, leader key)
- Defines buffer navigation keymaps (`<leader>h/l` for prev/next buffer)
- Leader key is `<space>`, local leader is `\`
- Tab settings: 2 spaces, expandtab enabled

### LSP Configuration (`lua/plugins/lsp-config.lua`)
- Uses Mason for LSP server management
- Configured servers: `lua_ls`, `ts_ls`, `gopls`
- Key bindings:
  - `K`: Hover info
  - `gd`: Go to definition (via Telescope)
  - `<leader>ca`: Code actions
- Diagnostic configuration with inline virtual text and floating windows

### Telescope (`lua/plugins/telescope.lua`)
- Fuzzy finder with UI-select extension
- Key bindings:
  - `<leader>ff`: Find files
  - `<leader>fg`: Live grep
  - `<leader>fb`: Buffers
  - `<leader>fh`: Help tags

### Formatting/Linting (`lua/plugins/none-ls.lua`)
- Uses none-ls (null-ls fork) for formatting and diagnostics
- Configured tools: eslint_d, stylua, prettier, golangci_lint, checkmake, sql_formatter
- Key binding: `<leader>fm`: Format current buffer

### File Explorer (`lua/plugins/neo-tree.lua`)
- Floating window file tree with git status and diagnostics
- Key bindings:
  - `<leader>e`: Toggle Neo-tree
  - `<leader>n`: Focus Neo-tree
  - `<leader>r`: Reveal current file in tree
- Navigation: `l` to open, `h` to close nodes

### Completion (`lua/plugins/completions.lua`)
- nvim-cmp with LuaSnip for snippets
- Sources: LSP, LuaSnip, buffer
- Standard completion keybindings with bordered windows

## Key Bindings Summary

**Buffer Management:**
- `<leader>l`: Next buffer
- `<leader>h`: Previous buffer
- `<leader>q`: Delete buffer
- `<leader>Q`: Force delete buffer

**File Operations:**
- `<leader>e`: Toggle file tree
- `<leader>ff`: Find files
- `<leader>fg`: Search in files

**LSP:**
- `K`: Show hover info
- `gd`: Go to definition
- `<leader>ca`: Code actions
- `<leader>fm`: Format buffer

## Languages Supported

- **Lua**: Full LSP support with vim globals recognition
- **TypeScript/JavaScript**: LSP with ts_ls server
- **Go**: LSP with gopls server
- **HTML/Vue/TSX**: Treesitter parsing and auto-tag completion

## Diagnostic Tools

- eslint_d for JavaScript/TypeScript
- golangci_lint for Go
- checkmake for Makefiles
- Built-in LSP diagnostics with floating windows on cursor hold

## Plugin Update Commands

- `:Lazy`: Open Lazy.nvim management interface
- `:TSUpdate`: Update Treesitter parsers
- `:Mason`: Open Mason LSP server management

## File Structure Notes

When modifying plugins:
1. Each plugin configuration should be in its own file in `lua/plugins/`
2. Files should return a table with plugin specifications
3. Follow existing patterns for keybindings and configuration structure
4. Use descriptive comments with emojis (as seen in existing files)