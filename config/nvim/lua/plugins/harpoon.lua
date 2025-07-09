-- lua/plugins/harpoon.lua

return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      local extensions = require 'harpoon.extensions'

      harpoon:setup()

      harpoon:extend(extensions.builtins.navigate_with_number())

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'harpoon add file' })
      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end, { desc = 'harpoon remove file' })

      vim.keymap.set('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'harpoon quick menu' })

      vim.keymap.set('n', '<leader>hg', function()
        harpoon:list():prev()
      end, { desc = 'go previous file' })
      vim.keymap.set('n', '<leader>hj', function()
        harpoon:list():next()
      end, { desc = 'go next file' })
    end,
  },
}
