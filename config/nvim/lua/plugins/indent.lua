-- lua/plugins/indent.lua

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
        -- char = ' ',
        -- tab_char = ' ',
        -- highlight = { 'Function', 'Label' },
      },
      -- whitespace = {
      --   highlight = { 'Function', 'Label' },
      -- },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },
}
