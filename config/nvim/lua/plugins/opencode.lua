-- lua/plugins/opencode.lua

return {
  {
    'cousine/opencode-context.nvim',
    opts = {
      tmux_target = nil, -- manual override: "session:window.pane"
      auto_detect_pane = true, -- auto-detect opencode pane in current window
    },
    keys = {
      { '<leader>oc', '<cmd>OpencodeSend<cr>', desc = 'send prompt to opencode' },
      { '<leader>oc', '<cmd>OpencodeSend<cr>', mode = 'v', desc = 'send prompt to opencode' },
      { '<leader>ot', '<cmd>OpencodeSwitchMode<cr>', desc = 'toggle opencode mode' },
      { '<leader>op', '<cmd>OpencodePrompt<cr>', desc = 'open opencode persistent prompt' },
    },
    cmd = { 'OpencodeSend', 'OpencodeSwitchMode' },
  },
  -- {
  --   'sudo-tee/opencode.nvim',
  --   config = function()
  --     require('opencode').setup {
  --       prefered_picker = 'telescope',
  --       default_global_keymaps = false,
  --       ui = {
  --         display_model = false,
  --         window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder', -- Highlight group for the opencode window
  --         output = {
  --           tools = {
  --             show_output = true,
  --           },
  --         },
  --       },
  --     }
  --   end,
  --   keys = {
  --     { '<leader>oa', '<cmd>Opencode<cr>', desc = 'open/close opencode' },
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     {
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         anti_conceal = { enabled = false },
  --         file_types = { 'markdown', 'opencode_output' },
  --       },
  --       ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
  --     },
  --   },
  -- },
}
