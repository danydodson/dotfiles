-- lua/plugins/showkeys.lua

return {
  {
    'nvzone/showkeys',
    cmd = 'ShowkeysToggle',
    opts = {
      position = 'bottom-right',
      timeout = 1,
      maxkeys = 3,
    },
  },
}
