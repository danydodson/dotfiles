-- lua/config/lazy.lua

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  ui = {
    border = require('core.art').border,
    icons = require('core.art').lazy,
  },
  install = {
    colorscheme = {},
  },
  spec = {
    {
      import = 'plugins',
    },
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    lazy = false,
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrePlugin',
        'tohtml',
        'tutor',
        'tarPlugin',
        'zipPlugin',
      },
    },
  },
}
