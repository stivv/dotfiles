local ok, packer = pcall(require, 'packer')

if (not ok) then
	print("packer not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lua/plenary.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'lewis6991/gitsigns.nvim'
	use 'rcarriga/nvim-notify'
	use 'numToStr/Comment.nvim'
	use 'akinsho/toggleterm.nvim'

	use 'navarasu/onedark.nvim'
	use 'tjdevries/colorbuddy.nvim'
	use { "catppuccin/nvim", as = "catppuccin" }

	use 'nvim-lualine/lualine.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'glepnir/lspsaga.nvim'
	use 'jose-elias-alvarez/null-ls.nvim'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'MunifTanjim/prettier.nvim'

	-- CMP
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use {
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
	}
	use 'saadparwaiz1/cmp_luasnip'
	use 'onsails/lspkind-nvim'
	use 'ray-x/lsp_signature.nvim'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate'
	}
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'

	-- Telescope
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'

end)
