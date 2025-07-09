-- lua/plugins/bufferline.lua

return {
  {},
  -- {
  --   'akinsho/bufferline.nvim',
  --   event = { 'BufReadPre', 'WinEnter' },
  --   version = '*',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   opts = {
  --     options = {
  --       always_show_bufferline = false,
  --       show_buffer_icons = false,
  --       show_close_icon = false,
  --       show_tab_indicators = false,
  --       diagnostics = 'nvim_lsp',
  --       close_command = function(n) require("mini.bufremove").delete(n, false) end,
  --       offsets = {
  --         {
  --           filetype = 'neo-tree',
  --           text = '',
  --           text_align = 'left',
  --           padding = 0,
  --         },
  --       },
  --     },
  --   },
  --   keys = {
  --     { '<leader>bd', '<cmd>:bp | bd #<cr>', desc = 'buffer delete' },
  --     { '<C-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'buffer next' },
  --     { '<C-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'buffer previous' },
  --     { '<leader>b|', '<cmd>vert belowright sb<cr>', desc = 'buffer split right' },
  --   },
  -- },
}
