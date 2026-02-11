-- lua/plugins/project.lua

return {
  {
    'zeioth/project.nvim',
    event = 'User BaseDefered',
    cmd = 'ProjectRoot',
    opts = {
      patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        '.solution',
        '.solution.toml',
      },

      exclude_dirs = {
        '~/',
      },

      silent_chdir = true,
      manual_mode = false,

      exclude_chdir = {
        filetype = { '', 'OverseerList', 'alpha' },
        buftype = { 'nofile', 'terminal' },
      },
    },

    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
}
