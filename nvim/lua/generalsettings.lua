-- General Settings

local bufr = vim.opt
local global = vim.o
local window = vim.wo
	
bufr.expandtab = true
bufr.shiftwidth = 2
bufr.softtabstop = 2
bufr.tabstop = 2
bufr.undofile = true
bufr.swapfile = false

global.hidden = true
global.title = true
global.ignorecase = true
global.smartcase = true
global.wildmode = 'longest:full,full'
global.mouse = 'a'
global.scrolloff = 30
global.sidescrolloff = 30
global.listchars = 'tab:  ,trail:·'
global.updatetime = 300 -- Reduce time for highlighting other refs
global.redrawtime = 10000 -- More time for loading syntax on large files
global.confirm = true
global.exrc = true
global.splitright = true

window.number = true
window.numberwidth = 4
window.relativenumber = true
window.signcolumn = 'number'
window.spell = true
window.wrap = false
window.list = true

-- ColorScheme
syntax = 'enable'
global.termguicolors = true
global.background = 'dark'
global.winblend = 0
global.wildoptions = 'pum'
global.pumblend = 5
-- Use NeoSolarized
vim.g.neosolarized_termtrans = 1
vim.runtime = '~/.configs/nvim/colors/NeoSolarized.vim'
vim.cmd [[colorscheme NeoSolarized]]
vim.opt.cursorline = true
