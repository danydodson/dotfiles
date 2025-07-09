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
          'cssls',
          'gopls',
          'html',
          'lua_ls',
          'marksman',
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

      local lspconfig = require 'lspconfig'
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.html.setup {
        capabilities = capabilities,
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
      }

      local capabilities_css = vim.lsp.protocol.make_client_capabilities()
      capabilities_css.textDocument.completion.completionItem.snippetSupport = true
      lspconfig.cssls.setup {
        capabilities = capabilities_css,
      }

      lspconfig.marksman.setup {
        capabilities = capabilities,
      }

      lspconfig.yamlls.setup {
        capabilities = capabilities,
      }

      lspconfig.bashls.setup {
        capabilities = capabilities,
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
      }

      lspconfig.pyright.setup {
        capabilities = capabilities,
      }

      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
      }

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
