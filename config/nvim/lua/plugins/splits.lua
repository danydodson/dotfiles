-- lua/plugins/splits
return {
  {
    'mrjones2014/smart-splits.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<C-h>',
        function()
          require('smart-splits').move_cursor_left()
        end,
        desc = 'move cursor to the left split',
      },
      {
        '<C-j>',
        function()
          require('smart-splits').move_cursor_down()
        end,
        desc = 'move cursor to the bottom split',
      },
      {
        '<C-k>',
        function()
          require('smart-splits').move_cursor_up()
        end,
        desc = 'move cursor to the top split',
      },
      {
        '<C-l>',
        function()
          require('smart-splits').move_cursor_right()
        end,
        desc = 'move cursor to the right split',
      },
    },
    config = function()
      require('smart-splits').setup()
    end,
  },
  {
    'szw/vim-maximizer',
    keys = {
      { '<leader>tm', '<cmd>MaximizerToggle<CR>', desc = 'maximize/minimize a split' },
    },
  },
}
