-- lua/plugins/indent.lua

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#e06c75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e5c07b' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61afef' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#d19a66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98c379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c678dd' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56b6c2' })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      require('ibl').setup {
        indent = {
          char = '│',
          tab_char = '│',
          -- highlight = highlight,
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
        },
      }
    end,
  },
}
