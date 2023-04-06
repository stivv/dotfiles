vim.g.mapleader = ' '

local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.background = 'dark'
opt.rnu = true
opt.undofile = true
opt.swapfile = false
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.updatetime = 250
opt.signcolumn = 'yes'

-- Keymaps
local noremap = { noremap = true, silent = true }
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
local mapkey = function(mode, key, cmd, opts)
	return vim.keymap.set(mode, key, cmd, opts)
end
mapkey('i', 'jj', '<Esc>', { desc = 'Faster escape' })
mapkey('n', '<C-a>', 'ggVG', { desc = 'Select all' })
mapkey('n', '<leader>h', '<cmd>bp<cr>', { desc = 'Go to previous buffer' })
mapkey('n', '<leader>l', '<cmd>bn<cr>', { desc = 'Go to next buffer' })
mapkey('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = 'Close current buffer' })
mapkey('n', '<leader>ba', ':%bd|e#|bd#<cr>', noremap)
-- Reselect visual selection after indenting
mapkey('v', '<', '<gv', noremap)
mapkey('v', '>', '>gv', noremap)
-- Remap for dealing with word wrap
mapkey('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
mapkey('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = 'plugins' },
		{ import = 'plugins.lsp.servers' },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
