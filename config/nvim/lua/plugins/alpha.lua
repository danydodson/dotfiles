-- lua/plugins/alpha.lua

local icons = require 'core.art'
local utils = require 'core.utils'

return {
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim',
    },
    enabled = true,
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'
      math.randomseed(os.time())
      dashboard.section.header.val = icons.ascii[math.random(1, #icons.ascii)]
      dashboard.section.header.opts.hl = 'DashboardHeader'

      local is_yazi_installed = vim.fn.executable 'ya' == 1
      local yazi_button = dashboard.button('y', ' ' .. utils.get_icon 'Terminal' .. ' Yazi', '<cmd>Yazi<CR>')
      if not is_yazi_installed then
        yazi_button = nil
      end

      dashboard.section.buttons.val = {
        dashboard.button('n', ' 󰻭' .. ' New', '<cmd>ene<CR>'),
        dashboard.button('p', ' ' .. ' Projects', '<cmd>Telescope projects<CR>'),
        dashboard.button('r', ' 󰕁' .. ' Recent', '<cmd>Telescope oldfiles<CR>'),
        dashboard.button('g', ' 󰺯' .. ' Grep', '<cmd>Telescope live_grep<CR>'),
        yazi_button,
        dashboard.button('l', ' 󰒲' .. ' Lazy', '<cmd> Lazy <CR>'),
        dashboard.button('q', ' ' .. ' Quit', '<cmd>exit<CR>'),
      }

      -- vertical margins
      dashboard.config.layout[1].val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.10) } -- Above header
      dashboard.config.layout[3].val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.10) } -- Above buttons

      dashboard.config.opts.noautocmd = true

      return dashboard
    end,
    config = function(_, opts)
      -- Footer
      require('alpha').setup(opts.config)
    end,
  },
}
