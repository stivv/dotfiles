-- [[ Setting options ]]

local opt = vim.opt

-- Set highlight on search
opt.hlsearch = false

-- Make line numbers default
opt.number = true
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = 'a'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250
opt.signcolumn = 'yes'

-- Set colorscheme
opt.termguicolors = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- Tab width
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
