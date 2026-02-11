-- lua/plugins/notify.lua

return {
  {
    'rcarriga/nvim-notify',
    event = 'User BaseDefered',
    opts = function()
      require('notify').setup {
        background_colour = '#000000',
      }
      return {
        timeout = 5500,
        fps = 144,

        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          -- enable markdown support on notifications
          vim.api.nvim_win_set_config(win, { zindex = 175 })
          if not vim.g.notifications_enabled then
            vim.api.nvim_win_close(win, true)
          end
          if not package.loaded['nvim-treesitter'] then
            pcall(require, 'nvim-treesitter')
          end
          vim.wo[win].conceallevel = 3
          local buf = vim.api.nvim_win_get_buf(win)
          if not pcall(vim.treesitter.start, buf, 'markdown') then
            vim.bo[buf].syntax = 'markdown'
          end
          vim.wo[win].spell = false
        end,
      }
    end,

    config = function(_, opts)
      local notify = require 'notify'
      notify.setup(opts)
      vim.notify = notify
    end,
  },
}
