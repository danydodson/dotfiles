-- lua/plugins/undotree.lua

return {
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<Leader>tu', '<cmd>UndotreeToggle<CR>', desc = 'toggle undo tree' },
    },
  },
}
