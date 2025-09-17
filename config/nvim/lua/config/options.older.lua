vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.spelllang = 'en'
vim.opt.spell = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.completeopt = 'menuone,noselect'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cmdheight = 0
vim.opt.scrolloff = 10
vim.opt.wrap = false

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autochdir = false
vim.opt.iskeyword:append 'a'
vim.opt.clipboard:append 'unnamedplus'
vim.opt.modifiable = true
vim.opt.guicursor = 'n:blinkon200,i-ci-ve:ver25'
vim.opt.encoding = 'UTF-8'
vim.opt.shortmess:append { s = true, I = true }

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undodir = os.getenv 'HOME' .. '/.config/vim/undodir'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = '/Users/stache/.config/miniconda3/bin/python'
