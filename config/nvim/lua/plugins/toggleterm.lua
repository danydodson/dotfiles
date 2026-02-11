-- lua/plugins/toggleterm.lua

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 15,
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
      hide_numbers = false,
      highlights = {
        Normal = {
          -- guibg = '#31353D',
        },
        NormalFloat = {
          -- link = 'Normal',
        },
        FloatBorder = {
          -- guifg = '#31353D',
          -- guibg = '#1f2328',
        },
      },
    },
  },
}
