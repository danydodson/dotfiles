-- lua/plugins/treesitter.lua

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local config = require 'nvim-treesitter.configs'
      config.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          'bash',
          'c',
          'css',
          'cpp',
          'diff',
          'dockerfile',
          'go',
          'gomod',
          'gosum',
          'html',
          'http',
          'javascript',
          'jsdoc',
          'json',
          'jsonc',
          'lua',
          'luap',
          'luadoc',
          'printf',
          'python',
          'nginx',
          'objc',
          'ocaml',
          'query',
          'regex',
          'rust',
          'sql',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'xml',
          'yaml',
        },
      }
    end,
  },
}
