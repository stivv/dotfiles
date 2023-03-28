local opts = vim.opt

opts.number = true
opts.relativenumber = true

opts.tabstop = 2
opts.shiftwidth = 2

opts.background = 'dark'
opts.termguicolors = true

opts.cmdheight = 0
opts.undofile = true
opts.swapfile = false

opts.completeopt = { 'menu', 'menuone', 'noselect' }

-- Case insensitive searching UNLESS /C or capital in search
opts.ignorecase = true
opts.smartcase = true

-- Set highlight on search
opts.hlsearch = false

-- Decrease update time
opts.updatetime = 250
opts.signcolumn = 'yes'
