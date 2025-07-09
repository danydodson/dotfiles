-- lua/plugins/toggleterm.lua

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
    },
  },
}
