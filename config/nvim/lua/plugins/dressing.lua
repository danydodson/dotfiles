-- lua/plugins/dressing.lua

return {
  {
    'stevearc/dressing.nvim',
    opts = {
      select = {
        input = { default_prompt = '➤ ' },
        backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },
      },
    },
  },
}
