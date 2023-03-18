require("options")

-- Lazy config
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

-- Setting up leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.extras.lang" },
		{ import = "plugins.extras.ui" },
		-- { import = "plugins.extras.pde" },
		-- { import = "plugins.extras.pde.notes" },
	},
	defaults = { lazy = true, version = nil },
	checker = { enabled = true },
	change_detection = {
		notify = false,
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

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("keymaps")
		require("autocmds")
	end,
})
