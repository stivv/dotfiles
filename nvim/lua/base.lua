local opt = vim.opt

opt.syntax = 'ON'
opt.number = true
opt.relativenumber = true
opt.signcolumn     = 'auto'

opt.smarttab    = true
opt.shiftwidth  = 2
opt.tabstop     = 2
opt.softtabstop = 2
opt.autoindent  = true
opt.breakindent = true

opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumblend = 5
opt.background = 'dark'

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
