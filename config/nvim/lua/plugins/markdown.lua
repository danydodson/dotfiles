-- lua/plugins/markdown.lua

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.nvim',
    },
    config = function()
      local config = require 'render-markdown'
      config.setup {
        enabled = true,
        preset = 'lazy',
        completions = {
          lsp = { enabled = true },
        },
        latex = {
          enabled = false,
        },
        heading = {
          width = 'full',
          min_width = 120,
          left_margin = 2,
          sign = false,
          position = 'inline',
          icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
          backgrounds = {
            'Headline1Bg',
            'Headline2Bg',
            'Headline3Bg',
            'Headline4Bg',
            'Headline5Bg',
            'Headline6Bg',
          },
          foregrounds = {
            'Headline1Fg',
            'Headline2Fg',
            'Headline3Fg',
            'Headline4Fg',
            'Headline5Fg',
            'Headline6Fg',
          },
        },
        paragraph = {
          left_margin = 2,
        },
        bullet = {
          left_pad = 2,
        },
        checkbox = {
          left_margin = 2,
        },
        code = {
          width = 'full',
          min_width = 120,
          left_margin = 2,
          sign = false,
          left_pad = 1,
          border = 'thick',
          language_pad = 3,
          language_icon = false,
          language_info = false,
          language_name = false,
        },
      }
    end,
  },
}
