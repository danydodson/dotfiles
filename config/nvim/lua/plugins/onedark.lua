-- lua/plugins/onedark.lua

return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    enabled = true,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        ending_tildes = false,
        code_style = {
          comments = 'none',
        },
        colors = {
          bg0 = '#1f2328'
          -- bg0 = '#282b32',
        },
        highlights = {},
        diagnostics = {
          darker = false,
          undercurl = false,
          background = true,
        },
      }
      require('onedark').load()
    end,
  },
}
