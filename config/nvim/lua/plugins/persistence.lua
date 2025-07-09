-- lua/plugins/persistence.lua

return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        '<leader>sr',
        function()
          require('persistence').load()
        end,
        desc = 'restore session',
      },
      {
        '<leader>ss',
        function()
          require('persistence').select()
        end,
        desc = 'select session',
      },
      {
        '<leader>sl',
        function()
          require('persistence').load { last = true }
        end,
        desc = 'restore last session',
      },
      {
        '<leader>sd',
        function()
          require('persistence').stop()
        end,
        desc = "don't save current session",
      },
    },
  },
}
