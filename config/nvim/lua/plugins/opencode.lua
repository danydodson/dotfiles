-- lua/plugins/opencode.lua

return {
  {
    "sudo-tee/opencode.nvim",
    config = function()
      require("opencode").setup({
        default_global_keymaps = false,
        keymap = {
          editor = {
            ['<leader>og'] = { 'toggle', desc = 'toggle opencode' },
            ['<leader>oi'] = { 'open_input', desc = 'open input' },
            ['<leader>oI'] = { 'open_input_new_session', desc = 'open input in new session' },
            ['<leader>oo'] = { 'open_output', desc = 'open output' },
            ['<leader>ot'] = { 'toggle_focus', desc = 'toggle focus' },
            ['<leader>oq'] = { 'close', desc = 'close opencode' },
            ['<leader>op'] = { 'configure_provider', desc = 'configure provider' },
            ['<leader>oz'] = { 'toggle_zoom', desc = 'toggle zoom' },
            ['<leader>ox'] = { 'swap_position', desc = 'swap position' },
            ['<leader>opa'] = { 'permission_accept', desc = 'accept permission' },
            ['<leader>opA'] = { 'permission_accept_all', desc = 'accept all permissions' },
            ['<leader>opd'] = { 'permission_deny', desc = 'deny permission' },
            ['<leader>ov'] = { 'paste_image', desc = 'paste image' },
            ['<leader>oS'] = { 'select_child_session', desc ='select a child session' },
            ['<leader>odm'] = { 'debug_message', desc ='open msg for debug' },
            ['<leader>odo'] = { 'debug_output', desc ='open output for debug' },
            ['<leader>ods'] = { 'debug_session', desc ='open session for debug' },
          },
          output_window = {
            ['<leader>oS'] = { 'select_child_session', desc ='select a child session' },
            ['<leader>oD'] = { 'debug_message', desc ='open msg for debug' },
            ['<leader>oO'] = { 'debug_output', desc ='open output for debug' },
            ['<leader>ods'] = { 'debug_session', desc ='open session for debug' },
          }
        },
        ui = {
          display_model = false,
          window_highlight = 'Normal:OpencodeBackground,FloatBorder:OpencodeBorder',
          output = {
            tools = {
              show_output = true,
            },
          },
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { 'markdown', 'opencode_output' },
        },
        ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
      },
      'saghen/blink.cmp',
      'folke/snacks.nvim',
    },
  }
}
