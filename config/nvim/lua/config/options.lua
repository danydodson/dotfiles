-- /lua/config/options.lua

vim.g.mapleader = ' ' -- Set the leader key to space
vim.g.maplocalleader = ',' -- Set the local leader key to comma

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.laststatus = 3 -- Global statusline
vim.opt.numberwidth = 2 -- Set the width of line numbers to 2 characters
vim.opt.termguicolors = true -- Enable true color support
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.fileencoding = 'utf-8' -- Set file encoding to UTF-8

vim.opt.cmdheight = 0 -- Hide command line when not in use
vim.opt.cursorline = true -- Don't highlight the current line
vim.opt.cursorlineopt = 'number' -- Only highlight line number of current line

vim.opt.foldenable = false -- Enable code folding
vim.opt.foldcolumn = '0' -- Don't show fold column
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldlevelstart = 99 -- Start with all folds open when opening a new file

vim.opt.pumblend = 5 -- Make popup menu slightly transparent
vim.opt.pumheight = 10 -- Limit popup menu height to 10 items
vim.opt.completeopt = 'menuone,noselect' -- Completion options: show menu even for single item, don't auto-select

vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.showmode = false -- Duplicates what a statusline plugin does so disabled
vim.opt.ruler = false -- Don't show cursor position in command line
vim.opt.showcmd = false -- Don't show partial commands in command line

vim.opt.incsearch = true -- Show search matches while typing
vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if pattern contains uppercase

vim.opt.autoread = true -- Automatically read file when changed outside of Vim
vim.opt.splitbelow = true -- Open new splits below
vim.opt.splitkeep = 'screen' -- Keep text on screen when creating splits
vim.opt.splitright = true -- Open new splits to the right

vim.opt.wrap = false -- Don't wrap long lines
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.softtabstop = 2 -- Number of spaces inserted when hitting Tab
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Number of spaces for indentation
vim.opt.smartindent = true -- Enable smart autoindenting

vim.opt.mouse = 'a' -- Enable mouse in all modes
vim.opt.mousescroll = 'ver:1,hor:0' -- Vertical scroll one line at a time, disable horizontal scroll
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor when scrolling
vim.opt.smoothscroll = true -- Enable smooth scrolling

vim.opt.conceallevel = 0 -- Don't hide/conceal any text
vim.opt.autochdir = false -- Automatically change directory to current file
vim.opt.inccommand = 'nosplit' -- Show effects of substitution in real time without split
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for all operations

vim.opt.wildignore = '*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc' -- Files to ignore in file operations

vim.opt.updatetime = 200 -- Reduce time for CursorHold events (affects swap file writing and plugins)
vim.opt.backup = false -- Don't create backup filesoptions
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undolevels = 10000 -- Maximum number of changes that can be undone
vim.opt.undodir = os.getenv 'HOME' .. '/.config/vim/undodir' -- Directory for storing undo files

vim.opt.guicursor = 'n:blinkon200,i-ci-ve:ver25' -- Set cursor style (blinking in normal mode, vertical bar in insert mode)
vim.opt.listchars = { tab = '▸ ', space = '·', trail = '·', nbsp = '␣', extends = '❯', precedes = '❮' } -- Characters for displaying whitespace
vim.opt.fillchars = { foldopen = ' ', foldclose = ' ', fold = ' ', foldsep = ' ', diff = '░', eob = ' ' } -- Characters for various UI elements

vim.opt.viewoptions:remove 'curdir' -- Don't save current directory in view files
vim.opt.backspace:append { 'nostop' } -- Make backspace work over line breaks
vim.opt.diffopt:append { 'algorithm:histogram', 'linematch:60' } -- Use histogram diff algorithm and enable line matching

vim.g.loaded_netrw = 1 -- Disable netrw file explorer
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin
vim.opt.shortmess:append { s = true, I = true } -- Shorten various messages and skip intro

vim.g.bigfile_size = 1024 * 1024 * 1.5 -- Set size threshold for big files (1.5MB)

-- LSP and plugin-related settings
vim.g.cmp_enabled = true -- Enable completion
vim.g.autoformat_enabled = false -- Disable automatic formatting
vim.g.icons_enabled = true -- Enable icons
vim.g.codeactions_enabled = true -- Enable code actions
vim.g.diagnostics_mode = 3 -- Set diagnostics mode
vim.g.inlay_hints_enabled = true -- Enable inlay hints
vim.g.lsp_signature_enabled = true -- Enable LSP signature help
vim.g.notifications_enabled = true -- Enable notifications
vim.g.codelens_enabled = true -- Enable codelens
vim.g.lsp_round_borders_enabled = true -- Enable rounded borders in LSP UI
vim.g.semantic_tokens_enabled = true -- Enable semantic tokens

-- Provider settings
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.loaded_perl_provider = 0 -- Disable Perl provider
vim.g.loaded_ruby_provider = 0 -- Disable Ruby provider
vim.g.python3_host_prog = "/opt/miniconda3/bin/python" -- Set Python 3 provider

-- Add LuaRocks paths to package.path
-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'
