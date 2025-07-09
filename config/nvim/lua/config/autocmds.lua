-- lua/config/autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd
local utils = require 'core.utils'
local is_available = utils.is_available

-- don't auto comment new line
autocmd({ 'FileType' }, {
  desc = 'Disables auto commenting next line',
  pattern = '*',
  callback = function()
    vim.cmd 'set formatoptions-=cro'
  end,
})

-- highlight on yank
autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- auto commands below does not work in vs code
if vim.g.vscode then
  return {}
end

autocmd({ 'VimEnter' }, {
  desc = 'Nvim user event that trigger a few ms after nvim starts',
  callback = function()
    -- If nvim is opened passing a filename, trigger the event inmediatelly.
    if #vim.fn.argv() >= 1 then
      -- In order to avoid visual glitches.
      utils.trigger_event('User BaseDefered', true)
      utils.trigger_event('BufEnter', true) -- also, initialize tabline_buffers.
    else -- Wait some ms before triggering the event.
      vim.defer_fn(function()
        utils.trigger_event 'User BaseDefered'
      end, 70)
    end
  end,
})

-- check if we need to reload the file when it changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  desc = 'Go to Last loc when Opening a buffer',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- terminal
autocmd({ 'TermOpen', 'TermEnter' }, {
  desc = 'Make Termainal took good',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.spell = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.laststatus = 0
    vim.api.nvim_command 'startinsert' --to start terminal in insert mood
  end,
})
autocmd({ 'TermLeave' }, {
  desc = 'Make Termainal took good',
  callback = function()
    vim.opt_local.laststatus = 2
  end,
})

-- resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- show cursor line only in active window
autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = augroup 'auto_cursorline_show',
  callback = function(event)
    if vim.bo[event.buf].buftype == '' then
      vim.opt_local.cursorline = true
    end
  end,
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = augroup 'auto_cursorline_hide',
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- fix conceallevel for json files
autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- autocmd to show diagnostics on cursorhold
autocmd('CursorHold', {
  desc = 'lsp show diagnostics on CursorHold',
  callback = function()
    local hover_opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
    }
    vim.diagnostic.open_float(nil, hover_opts)
  end,
})

-- code folding type depends on file
autocmd({ 'FileType' }, {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})

-- close some filetypes with <q>
autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- lsp hover autocmd to show diagnostics on cursorhold
autocmd('CursorHold', {
  desc = 'lsp show diagnostics on CursorHold',
  callback = function()
    local hover_opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
    }
    vim.diagnostic.open_float(nil, hover_opts)
  end,
})

-- launch alpha greeter on startup
if is_available 'alpha-nvim' then
  autocmd({ 'User', 'BufEnter' }, {
    desc = 'Disable status and tablines for alpha',
    callback = function(args)
      local is_filetype_alpha = vim.api.nvim_get_option_value('filetype', { buf = 0 }) == 'alpha'
      local is_empty_file = vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'nofile'
      if ((args.event == 'User' and args.file == 'AlphaReady') or (args.event == 'BufEnter' and is_filetype_alpha)) and not vim.g.before_alpha then
        vim.g.before_alpha = {
          -- showtabline = vim.opt.showtabline:get(),
          laststatus = vim.opt.laststatus:get(),
        }
        vim.opt.showtabline, vim.opt.laststatus = 0, 0
      elseif vim.g.before_alpha and args.event == 'BufEnter' and not is_empty_file then
        vim.opt.laststatus = vim.g.before_alpha.laststatus
        vim.opt.showtabline = vim.g.before_alpha.showtabline
        vim.g.before_alpha = nil
      end
    end,
  })

  autocmd('VimEnter', {
    desc = 'Start Alpha only when nvim is opened with no arguments',
    callback = function()
      -- precalculate conditions.
      local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
      local buf_not_empty = vim.fn.argc() > 0 or #lines > 1 or (#lines == 1 and lines[1]:len() > 0)
      local buflist_not_empty = #vim.tbl_filter(function(bufnr)
        return vim.bo[bufnr].buflisted
      end, vim.api.nvim_list_bufs()) > 1
      local buf_not_modifiable = not vim.o.modifiable

      -- return instead of opening alpha if any of these conditions occur.
      if buf_not_modifiable or buf_not_empty or buflist_not_empty then
        return
      end
      for _, arg in pairs(vim.v.argv) do
        if arg == '-b' or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then
          return
        end
      end

      -- all good? show alpha.
      require('alpha').start(true, require('alpha').default_config)
      vim.schedule(function()
        vim.cmd.doautocmd 'FileType'
      end)
    end,
  })
end
