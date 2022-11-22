vim.cmd('autocmd!')

local opt = vim.opt
local wo = vim.wo

vim.g.mapleader = " "
-- vim.notify = require('notify')

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.title = true

opt.undofile   = true
opt.swapfile   = false
opt.modifiable = true
opt.backup     = false

opt.hlsearch   = true
opt.incsearch  = true
opt.ignorecase = true
opt.smartcase  = true

opt.splitbelow = true
opt.splitright = true
opt.wrap       = false
opt.scrolloff  = 5

opt.relativenumber = true
opt.cursorline     = true
opt.signcolumn     = 'auto'

opt.hidden      = true
opt.completeopt = 'menuone,noselect'
opt.mouse       = 'a'

opt.smarttab    = true
opt.shiftwidth  = 2
opt.tabstop     = 2
opt.softtabstop = 2
opt.autoindent  = true
opt.breakindent = true

opt.showcmd    = true
opt.cmdheight  = 1
opt.laststatus = 2
vim.o.shell    = '/bin/zsh'

opt.backupskip = '/tmp/*,/private/tmp/*'
opt.inccommand = 'split'

opt.backspace = 'start,eol,indent'
opt.path:append { '**' } -- search include subfolders
opt.wildignore:append { '*/node_modules/*' }

opt.list      = true
opt.listchars = { tab = '»·', trail = '·', precedes = '', extends = '' }

-- Undercurl
vim.cmd([[let &t_Cs = '\e[4:3m']])
vim.cmd([[let &t_Ce = '\e[4:0m']])

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = '*',
	command = 'set nopaste'
})

opt.formatoptions:append { 'r' }
