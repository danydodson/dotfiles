-- lua/plugins/gitsigns.lua

return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local icons = require 'core.art'
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = false,
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end)

          -- map('n', '<leader>hs', gitsigns.stage_hunk)
          -- map('n', '<leader>hr', gitsigns.reset_hunk)
          -- map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          -- map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          -- map('n', '<leader>hS', gitsigns.stage_buffer)
          -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
          -- map('n', '<leader>hR', gitsigns.reset_buffer)
          -- map('n', '<leader>hp', gitsigns.preview_hunk)
          -- map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = 'git signs blame' })
          -- map('n', '<leader>hd', gitsigns.diffthis)
          -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)

          -- map('n', '<leader>td', gitsigns.toggle_deleted)
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'git signs toggle for line' })
        end,
      }
    end,
  },
}
