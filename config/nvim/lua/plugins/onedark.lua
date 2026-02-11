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
          bg0 = '#1f2328',
          bg0_ = '#282b32',
          col_bg0 = '#e06c75',
          col_bg1 = '#98c379',
          col_bg2 = '#61afef',
          col_bg3 = '#c678dd',
          col_bg4 = '#c2cb6a',
          col_bg5 = '#e5c07b',
          col_fg1 = '#323449',
          col_sg1 = '#ebfafa',
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
