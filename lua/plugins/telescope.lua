return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      -- Enhanced telescope setup
      telescope.setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          path_display = { "truncate" },
          -- file_ignore_patterns = {
          --   "node_modules",
          --   ".git/",
          --   "dist/",
          --   "build/",
          --   "target/",
          -- },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
          },
          live_grep = {
            theme = "ivy",
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = "delete_buffer",
              },
              n = {
                ["dd"] = "delete_buffer",
              },
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
              },
            },
          },
        },
      })

      -- Load extensions
      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')
      telescope.load_extension('live_grep_args')

      -- Enhanced telescope keymaps
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', { desc = 'Telescope live grep with args' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope recent files' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope commands' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope grep string under cursor' })
      vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, { desc = 'Telescope fuzzy find in buffer' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope resume last search' })
      vim.keymap.set('n', '<leader>ft', builtin.colorscheme, { desc = 'Telescope colorschemes' })
      
      -- Git telescope keymaps
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope git files' })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git status' })
    end,
  }
}

