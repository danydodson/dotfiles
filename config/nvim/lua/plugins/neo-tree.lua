-- lua/plugins/neo-tree.lua

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Neotree',
    keys = {
      { '<leader>e', ':Neotree filesystem toggle<CR>', { noremap = true, silent = true, desc = 'neotree' } },
    },
    opts = function()
      vim.g.neo_tree_remove_legacy_commands = true

      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      local utils = require 'core.utils'
      local get_icon = utils.get_icon

      return {
        auto_clean_after_session_restore = true,
        hide_root_node = true,
        add_blank_line_at_top = false,
        enable_diagnostics = false,
        enable_git_status = false,
        close_if_last_window = true,
        buffers = { show_unloaded = true },
        sources = { 'filesystem', 'buffers', 'git_status' },
        source_selector = {
          winbar = false,
          content_layout = 'center',
          sources = {
            { source = 'filesystem', display_name = get_icon('Files', 0) .. ' File' },
            { source = 'buffers', display_name = '󰈙' .. ' Bufs' },
            { source = 'git_status', display_name = '󰊢' .. ' Git' },
            { source = 'diagnostics', display_name = '󰒡' .. ' Diagnostic' },
          },
        },
        default_component_configs = {
          indent = {
            padding = 0,
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            folder_empty_open = '',
            default = '󰈙',
            highlight = 'NeoTreeFileIcon',
          },
          modified = {
            symbol = '',
          },
          name = {
            use_git_status_colors = false,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '',
              renamed = '➜',
              untracked = '★',
              ignored = '◌',
              unstaged = '✗',
              staged = '✓',
              conflict = '',
            },
          },
        },
        window = {
          width = 25,
          mappings = {
            ['.'] = 'set_root',
            ['<esc>'] = 'cancel',
            ['l'] = { 'toggle_node', nowait = true },
            ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          hijack_netrw_behavior = 'open_current',
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { '.git', '.DS_Store', "Icon'$'\r" },
          },
        },
        event_handlers = {
          {
            event = 'neo_tree_buffer_enter',
            handler = function(_)
              vim.opt_local.signcolumn = 'no'
            end,
          },
        },
      }
    end,
  },
}
