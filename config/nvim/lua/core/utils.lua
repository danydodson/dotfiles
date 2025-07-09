-- lua/core/utils.lua

local M = {}

function M.mappings(tbl, options)
  ---@diagnostic disable-next-line: lowercase-global
  for mode, values in pairs(tbl) do
    local gopts = vim.tbl_deep_extend('force', { mode = mode }, options or { silent = true })
    for keybind, info in pairs(values) do
      local opts = vim.tbl_deep_extend('force', gopts, info.opts or {})
      info.opts, opts.mode = nil, nil
      opts.desc = info[2]

      vim.keymap.set(mode, keybind, info[1], opts)
    end
  end
end

-- run a shell command and capture the output and if the command succeeded or failed.
function M.run_cmd(cmd, show_error)
  if type(cmd) == 'string' then
    cmd = vim.split(cmd, ' ')
  end
  if vim.fn.has 'win32' == 1 then
    cmd = vim.list_extend({ 'cmd.exe', '/C' }, cmd)
  end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar 'shell_error' == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_err_writeln(('Error running command %s\nError message:\n%s'):format(table.concat(cmd, ' '), result))
  end
  return success and result:gsub('[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]', '') or nil
end

-- sends a notification with 'neovim' as default title.
-- same as using vim.notify, but it saves us typing the title every time.
function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, vim.tbl_deep_extend('force', { title = 'Neovim' }, opts or {}))
  end)
end

-- adds autocmds to a specific buffer if they don't already exist.
function M.add_autocmds_to_buffer(augroup, bufnr, autocmds)
  -- Check if autocmds is a list, if not convert it to a list
  if not vim.islist(autocmds) then
    autocmds = { autocmds }
  end

  -- attempt to retrieve existing autocmds associated with the specified augroup and bufnr
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

  -- if no existing autocmds are found or the cmds_found call fails
  if not cmds_found or vim.tbl_isempty(cmds) then
    -- create a new augroup if it doesn't already exist
    vim.api.nvim_create_augroup(augroup, { clear = false })

    -- iterate over each autocmd provided
    for _, autocmd in ipairs(autocmds) do
      -- extract the events from the autocmd and remove the events key
      local events = autocmd.events
      autocmd.events = nil

      -- set the group and buffer keys for the autocmd
      autocmd.group = augroup
      autocmd.buffer = bufnr

      -- create the autocmd
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

-- deletes autocmds associated with a specific buffer and autocmd group.
function M.del_autocmds_from_buffer(augroup, bufnr)
  -- Attempt to retrieve existing autocmds associated with the specified augroup and bufnr
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

  -- if retrieval was successful
  if cmds_found then
    -- map over each retrieved autocmd and delete it
    vim.tbl_map(function(cmd)
      vim.api.nvim_del_autocmd(cmd.id)
    end, cmds)
  end
end

-- get an icon from `lspkind` if it is available and return it.
function M.get_icon(kind, padding, no_fallback)
  if not vim.g.icons_enabled and no_fallback then
    return ''
  end
  local icon_pack = vim.g.icons_enabled and 'icons' or 'text'
  if not M[icon_pack] then
    M.icons = require 'core.art'
    M.text = require 'core.art'
  end
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(' ', padding or 0) or ''
end

-- check if a plugin is defined in lazy. Useful with lazy loading
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

-- set a table of mappings.
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == 'table' then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd or keymap_opts.name then -- if which-key mapping, queue it
          if not keymap_opts.name then
            keymap_opts.name = keymap_opts.desc
          end
          if not M.which_key_queue then
            M.which_key_queue = {}
          end
          if not M.which_key_queue[mode] then
            M.which_key_queue[mode] = {}
          end
          M.which_key_queue[mode][keymap] = keymap_opts
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  -- if which-key is loaded already, register
  if package.loaded['which-key'] then
    M.which_key_register()
  end
end

function M.toggle_diagnostics_ghost_text()
  if vim.diagnostic.config().virtual_text == false then
    vim.diagnostic.config {
      virtual_text = {
        source = 'always',
        prefix = '●',
      },
    }
  else
    vim.diagnostic.config {
      virtual_text = false,
    }
  end
end

function M.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
  end
end

function M.setFiletype()
  vim.ui.input({ prompt = 'Enter FileType: ' }, function(input)
    local ft = input
    if not input or input == '' then
      ft = vim.bo.filetype
    end
    vim.o.filetype = ft
  end)
end

-- convenient wapper to save code when we Trigger events.
-- to listen for a event triggered by this function you can use `autocmd`.
function M.trigger_event(event, is_urgent)
  -- define behavior
  local function trigger()
    local is_user_event = string.match(event, '^User ') ~= nil
    if is_user_event then
      event = event:gsub('^User ', '')
      vim.api.nvim_exec_autocmds('User', { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end

  -- execute
  if is_urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
end

--- convert a path to the path format of the current operative system.
--- it converts 'slash' to 'inverted slash' if on windows, and vice versa on UNIX.
function M.os_path(path)
  if path == nil then
    return nil
  end
  -- Get the platform-specific path separator
  local separator = string.sub(package.config, 1, 1)
  return string.gsub(path, '[/\\]', separator)
end

-- get the options of a plugin managed by lazy.
function M.get_plugin_opts(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  local lazy_plugin_avail, lazy_plugin = pcall(require, 'lazy.core.plugin')
  local opts = {}
  if lazy_config_avail and lazy_plugin_avail then
    local spec = lazy_config.spec.plugins[plugin]
    if spec then
      opts = lazy_plugin.values(spec, 'opts')
    end
  end
  return opts
end

-- returns true if the file is considered a big file,
-- according to the criteria defined in `vim.g.big_file`.
function M.is_big_file(bufnr)
  if bufnr == nil then
    bufnr = 0
  end
  local filesize = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
  local nlines = vim.api.nvim_buf_line_count(bufnr)
  local is_big_file = (filesize > vim.g.big_file.size) or (nlines > vim.g.big_file.lines)
  return is_big_file
end

-- check:
M.check = {
  -- provides check fn to check commands and files etc.
  vimcmd = function(string)
    if vim.fn.exists(':' .. string) > 0 then
      return true
    end
    return false
  end,

  file_exists = function(file)
    local f = io.open(file, 'rb')
    if f then
      f:close()
    end
    return f ~= nil
  end,

  lines_from_file = function(file)
    if not M.file_exists(file) then
      return {}
    end
    local lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
  end,
}

return M
