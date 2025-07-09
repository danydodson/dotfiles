-- lua/plugins/devicons.lua

return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {},
    config = function(_, opts)
      require('nvim-web-devicons').setup(opts)
      pcall(vim.api.nvim_del_user_command, 'NvimWebDeviconsHiTest')
    end,
  },
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    event = 'VeryLazy',
    config = function()
      require('tiny-devicons-auto-colors').setup {}
    end,
  },
}
