-- lua/plugins/treesitter.lua

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { 'python', 'yaml' },
        },
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
          'lua',
          'luap',
          'luadoc',
          'markdown',
          'markdown_inline',
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
