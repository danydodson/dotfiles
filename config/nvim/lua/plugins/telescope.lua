-- lua/plugins/telescope.lua

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local actions = require 'telescope.actions'

      require('telescope').setup {
        pickers = {
          find_files = {
            hidden = true,
          },
        },

        mappings = {
          i = { ['<esc>'] = actions.close },
        },

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }

      local builtin = require 'telescope.builtin'
      local utils = require 'core.utils'
      local config_dir = utils.os_path(vim.fn.stdpath 'config')
      local dotfiles_dir = os.getenv 'HOME' .. '/.dotfiles'

      local find_files = function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
        }
      end

      local find_config_files = function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden', config_dir },
        }
      end

      local find_dotfiles = function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden', dotfiles_dir },
        }
      end

      vim.keymap.set('n', '<leader><leader>', find_files)
      vim.keymap.set('n', '<leader>ff', find_files, { desc = 'search files' })
      vim.keymap.set('n', '<leader>fc', find_config_files, { desc = 'search nvim configs' })
      vim.keymap.set('n', '<leader>fd', find_dotfiles, { desc = 'search dotfiles' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'search resume' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'search current word' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'search by grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'search buffers' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'search diagnostics' })
      vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'search select telescope' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'search keymaps' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'search help' })
      vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'search man pages' })
      vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'search git status' })
      vim.keymap.set('n', '<C-p>', builtin.oldfiles, { desc = 'search recents' })

      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'projects'
    end,
  },
}
