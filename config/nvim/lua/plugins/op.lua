-- lua/plugins/op.lua

return {
  {
    'mrjones2014/op.nvim',
    build = 'make install',
    config = function()
      require('op').setup {
        statusline_fmt = function(account_name)
          if not account_name or #account_name == 0 then
            return ' 1Password: No active session'
          end
          return string.format(' 1Password: %s', account_name)
        end,
      }
    end,
  },
}
