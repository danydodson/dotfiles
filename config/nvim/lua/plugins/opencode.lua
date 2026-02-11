-- lua/plugins/opencode.lua

return {
  {
    'sudo-tee/opencode.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          anti_conceal = { enabled = false },
          file_types = {
            'markdown',
            'opencode_output',
          },
        },
        ft = {
          'markdown',
          'Avante',
          'copilot-chat',
          'opencode_output',
        },
      },
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('opencode').setup {
        default_global_keymaps = false,
        keymap = {
          editor = {
            ['<leader>oi'] = { 'toggle_focus', desc = 'opencode toggle' },
            ['<leader>oc'] = { 'close', desc = 'opencode close' },
            ['<leader>oo'] = { 'open_input', desc = 'opencode input' },
          },
        },
        ui = {
          position = 'right',
          input_position = 'bottom',
          window_width = 0.48,
          zoom_width = 0.8,
          input_height = 0.12,
          display_model = true,
          display_context_size = true,
          display_cost = true,
          window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder',
          output = {
            tools = {
              show_output = true,
              show_reasoning_output = true,
            },
            rendering = {
              markdown_debounce_ms = 250,
              on_data_rendered = false,
            },
          },
          input = {
            text = {
              wrap = false,
            },
          },
        },
      }
    end,
  },
}
