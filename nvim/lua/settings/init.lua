local set = vim.opt

vim.notify = require('notify')

set.expandtab  = true
set.smarttab   = true
set.shiftwidth = 2
set.tabstop    = 2
set.undofile   = true
set.swapfile   = false
set.modifiable = true

set.hlsearch   = true
set.incsearch  = true
set.ignorecase = true
set.smartcase  = true

set.splitbelow   = true
set.splitright   = true
set.wrap         = false
set.scrolloff    = 5
set.fileencoding = 'utf-8'

set.relativenumber = true
set.cursorline     = true
set.signcolumn     = 'auto'

set.hidden      = true
set.completeopt = 'menuone,noselect'
set.mouse       = 'a'

-- colorscheme stuff
syntax            = 'on'
set.termguicolors = true
set.background    = 'dark'
set.winblend      = 0
set.wildoptions   = 'pum'
set.pumblend      = 5

-- Stop comments on new line
vim.cmd([[autocmd BufWinEnter * set formatoptions-=r formatoptions-=0]])
