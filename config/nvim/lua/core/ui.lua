-- lua/core/ui.lua

local M = {}
local utils = require 'core.utils'
local function bool2str(bool)
  return bool and 'on' or 'off'
end

-- toggle notifications for ui toggles
function M.toggle_ui_notifications()
  vim.g.notifications_enabled = not vim.g.notifications_enabled
  utils.notify(string.format('Notifications %s', bool2str(vim.g.notifications_enabled)))
end

-- toggle auto format
function M.toggle_autoformat()
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  utils.notify(string.format('Global autoformatting %s', bool2str(vim.g.autoformat_enabled)))
end

-- toggle cmp entrirely
function M.toggle_cmp()
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  local ok, _ = pcall(require, 'cmp')
  utils.notify(ok and string.format('completion %s', bool2str(vim.g.cmp_enabled)) or 'completion not available')
end

-- toggle lsp signature
function M.toggle_lsp_signature()
  local state = require('lsp_signature').toggle_float_win()
  utils.notify(string.format('lsp signature %s', bool2str(state)))
end

--- toggle foldcolumn=0|1
local last_active_foldcolumn
function M.toggle_foldcolumn()
  local curr_foldcolumn = vim.wo.foldcolumn
  if curr_foldcolumn ~= '0' then
    last_active_foldcolumn = curr_foldcolumn
  end
  vim.wo.foldcolumn = curr_foldcolumn == '0' and (last_active_foldcolumn or '1') or '0'
  utils.notify(string.format('foldcolumn=%s', vim.wo.foldcolumn))
end

-- toggle signcolumn="auto"|"no"
function M.toggle_signcolumn()
  if vim.wo.signcolumn == 'no' then
    vim.wo.signcolumn = 'yes'
  elseif vim.wo.signcolumn == 'yes' then
    vim.wo.signcolumn = 'auto'
  else
    vim.wo.signcolumn = 'no'
  end
  utils.notify(string.format('signcolumn=%s', vim.wo.signcolumn))
end

-- toggle laststatus=3|2|0
function M.toggle_statusline()
  local laststatus = vim.opt.laststatus:get()
  local status
  if laststatus == 0 then
    vim.opt.laststatus = 2
    status = 'local'
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
    status = 'global'
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
    status = 'off'
  end
  utils.notify(string.format('statusline %s', status))
end

-- toggle codelens
function M.toggle_codelens(bufnr)
  bufnr = bufnr or 0
  vim.g.codelens_enabled = not vim.g.codelens_enabled
  if vim.g.codelens_enabled then
    vim.lsp.codelens.refresh { bufnr = bufnr }
  else
    vim.lsp.codelens.clear()
  end
  utils.notify(string.format('CodeLens %s', bool2str(vim.g.codelens_enabled)))
end

-- toggle diagnostics
function M.toggle_diagnostics()
  vim.g.diagnostics_mode = (vim.g.diagnostics_mode - 1) % 4
  vim.diagnostic.config(require('core.lsp').diagnostics[vim.g.diagnostics_mode])
  if vim.g.diagnostics_mode == 0 then
    utils.notify 'diagnostics off'
  elseif vim.g.diagnostics_mode == 1 then
    utils.notify 'only status diagnostics'
  elseif vim.g.diagnostics_mode == 2 then
    utils.notify 'virtual text off'
  else
    utils.notify 'all diagnostics on'
  end
end

return M
