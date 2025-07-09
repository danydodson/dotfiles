-- lua/plugins/hardtime.lua

return {
  {
    'm4xshen/hardtime.nvim',
    lazy = true,
    event = 'VeryLazy',
    enabled = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      -- disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'oil' },
      -- disabled_keys = { ['<Up>'] = {}, ['<Space>'] = { 'n', 'x' } },
    },
  },
}
