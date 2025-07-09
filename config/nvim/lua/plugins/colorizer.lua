-- lua/plugins/colorizer.lua

return {
  {
    'norcalli/nvim-colorizer.lua',
    opts = { '*' },
    event = 'BufReadPost',
    config = true,
  },
}
