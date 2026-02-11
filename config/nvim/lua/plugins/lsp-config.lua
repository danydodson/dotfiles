-- lua/plugins/lsp-config.lua

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '⟳',
            package_uninstalled = '✗',
          },
          border = 'rounded',
        },
      }
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'bashls',
          'clangd',
          'cssls',
          'gopls',
          'html',
          'lua_ls',
          'tailwindcss',
          'ts_ls',
          'yamlls',
        },
      }
    end,
    opts = {
      auto_install = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local capabilities_css = vim.lsp.protocol.make_client_capabilities()
      capabilities_css.textDocument.completion.completionItem.snippetSupport = true

      vim.lsp.config('bashls', {
        -- Server-specific settings. See `:help lsp-quickstart`
        settings = { ['bashls'] = { capabilities = capabilities } },
      })
      vim.lsp.config('clangd', {
        settings = { ['clangd'] = { capabilities = capabilities, filetypes = { 'c', 'cpp', 'objc', 'objcpp' } } },
      })
      vim.lsp.config('cssls', {
        settings = { ['cssls'] = { capabilities = capabilities_css } },
      })
      vim.lsp.config('html', {
        settings = { ['html'] = { capabilities = capabilities } },
      })
      vim.lsp.config('lua_ls', {
        settings = { ['lua_ls'] = { capabilities = capabilities } },
      })
      vim.lsp.config('pyright', {
        settings = { ['pyright'] = { capabilities = capabilities } },
      })
      vim.lsp.config('rust_analyzer', {
        settings = { ['rust_analyzer'] = { capabilities = capabilities } },
      })
      vim.lsp.config('tailwindcss', {
        settings = { ['tailwindcss'] = { capabilities = capabilities } },
      })
      vim.lsp.config('ts_ls', {
        settings = { ['ts_ls'] = { capabilities = capabilities } },
      })
      vim.lsp.config('yamlls', {
        settings = { ['yamlls'] = { capabilities = capabilities } },
      })

      vim.lsp.enable('bashls', 'cssls', 'html', 'lua_ls', 'pyright', 'rust_analyzer', 'tailwindcss', 'ts_ls', 'yamlls')

      vim.keymap.set('n', '<leader>ci', vim.lsp.buf.hover, { desc = 'hover info' })
      vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = 'code go to definition' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, { desc = 'code list reference' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'code show action' })

      vim.keymap.set('n', 'df', vim.diagnostic.open_float, { desc = 'diag open float' })
      vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev, { desc = 'diag go to previous' })
      vim.keymap.set('n', 'dn', vim.diagnostic.goto_next, { desc = 'diag go to next' })
    end,
  },
}
