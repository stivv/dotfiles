local opt = vim.opt
vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.background = "dark"
opt.rnu = true
opt.undofile = true
opt.swapfile = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.updatetime = 250
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.list = true
opt.timeoutlen = 300
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.shortmess:append({ W = true, I = true, c = true })
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

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
		{ import = "plugins" },
		{ import = "plugins.lsp.servers" },
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

require("statusline")
require("keymaps")
require("autocmd")
