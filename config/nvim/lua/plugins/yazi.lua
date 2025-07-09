-- lua/plugins/yazi.lua

return {
  {
    'mikavilpas/yazi.nvim',
    event = 'User BaseDefered',
    cmd = { 'Yazi', 'Yazi cwd', 'Yazi toggle' },
    opts = {
      open_for_directories = false,
    },
  },
}
