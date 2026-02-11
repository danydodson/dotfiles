-- lua/plugins/none-ls.lua

return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'gbprod/none-ls-shellcheck.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,

          null_ls.builtins.formatting.shfmt,
          require 'none-ls-shellcheck.diagnostics',
          require 'none-ls-shellcheck.code_actions',

          -- require("none-ls.diagnostics.eslint_d"),
          -- require("none-ls.code_actions.eslint_d"),

          null_ls.builtins.diagnostics.staticcheck,

          null_ls.builtins.formatting.prettier.with {
            prefer_local = 'node_modules/.bin',
            filetypes = {
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'vue',
              'css',
              'scss',
              'less',
              'html',
              'json',
              'jsonc',
              'yaml',
              'markdown',
              'markdown.mdx',
              'graphql',
              'handlebars',
            },
            extra_filetypes = { 'toml', 'svelte' },
            extra_args = { '--tabWidth', '2', '--semi', 'true', '--print-width', '120', '--prose-wrap', 'never' },
          },
        },
      }
      vim.keymap.set('n', '<leader>zz', vim.lsp.buf.format, { desc = 'format file' })
    end,
  },
}
