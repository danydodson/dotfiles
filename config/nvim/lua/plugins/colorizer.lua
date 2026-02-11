-- lua/plugins/colorizer.lua

return {
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufReadPost',
    config = true,
    opts = {
      '*',
      css = { rgb_fn = true },
      html = { names = false },
    },
  },
}
