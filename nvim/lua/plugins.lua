-- Install packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Initialize packer
require('packer').init({
	compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'solid' })
		end,
	},
})

-- Install plugins
local use = require('packer').use

use('wbthomason/packer.nvim') -- Let packer manage itself

use 'lewis6991/impatient.nvim'

-- Colorscheme
use { 'navarasu/onedark.nvim', config = require 'p/colorscheme' }

-- Treesitter
use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		ts_update()
	end,
	config = require 'p/treesitter'
}
use { 'windwp/nvim-autopairs', config = require 'p.autopairs' }
use { 'windwp/nvim-ts-autotag', config = require 'p.autotag' }

-- LSP/Completions
use { 'neovim/nvim-lspconfig', config = require 'p.lspconfig' }
use { 'williamboman/mason.nvim', config = require 'p.mason' }
use {
	'kosayoda/nvim-lightbulb',
	requires = 'antoinemadec/FixCursorHold.nvim',
}
use({
	'hrsh7th/nvim-cmp',
	requires = {
		'L3MON4D3/LuaSnip',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-nvim-lua',
		'onsails/lspkind-nvim',
		'glepnir/lspsaga.nvim',
		'saadparwaiz1/cmp_luasnip',
		'ray-x/lsp_signature.nvim',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		require 'p.cmp'
		require 'p.luasnip'
		require 'p.lspsaga'
	end,
})

-- Bufferline
use({
	'akinsho/bufferline.nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	after = 'onedark.nvim',
	config = require 'p.bufferline'
})

-- lualine
use({
	'nvim-lualine/lualine.nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	config = require 'p.lualine',
})

-- Floaterm
use({ 'voldikss/vim-floaterm', config = require 'p.floaterm' })

-- Telescope
use({
	'nvim-telescope/telescope.nvim',
	requires = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'kyazdani42/nvim-web-devicons' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		{ 'nvim-telescope/telescope-live-grep-args.nvim' },
		{ 'nvim-telescope/telescope-file-browser.nvim' },
	},
	config = require 'p.telescope'
})

-- Comments
use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

-- Gitsigns
use { 'lewis6991/gitsigns.nvim', config = require 'p.gitsigns' }

-- Neoscroll
use { 'karb94/neoscroll.nvim', config = require 'p.neoscroll' }

-- Automatically install plugins on first run
if packer_bootstrap then require('packer').sync() end

-- Automatically regenerate compiled loader file on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
