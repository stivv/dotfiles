-- Plugins

vim.cmd [[packadd packer.nvim]]

require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'

	-- colorscheme
	use 'morhetz/gruvbox'
	vim.cmd [[colorscheme gruvbox]]

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		requires = { { 'nvim-treesitter/nvim-treesitter-refactor' } },
		config = function() require 'p/treesitter' end,
	}
	use {
		'windwp/nvim-autopairs',
		config = function()
			require 'nvim-autopairs'.setup { disable_filetypes = { 'TelescopePrompt', 'vim' } }
		end
	}
	use { 'windwp/nvim-ts-autotag', config = function() require 'nvim-ts-autotag'.setup {} end }

	-- lualine
	use { 'nvim-lualine/lualine.nvim', config = function() require 'p/lualine' end }

	-- comments
	use { 'numToStr/Comment.nvim', config = function() require 'Comment'.setup {} end }

	-- Telescope
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

	-- lsp
	use {
		'hrsh7th/nvim-cmp',
		requires = { {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets',
			'ray-x/lsp_signature.nvim',
			'onsails/lspkind-nvim',
		} },
		config = function()
			require 'p/lsp'
			require 'p/lspkind'
		end
	}
	use { 'williamboman/mason.nvim', config = function() require 'mason'.setup {} end }

	-- Notify
	use {
		'rcarriga/nvim-notify',
		config = function()
			vim.notify = require 'notify'
		end
	}
end)
