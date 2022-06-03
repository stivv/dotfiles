return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'rcarriga/nvim-notify'
  use 'nvim-lualine/lualine.nvim'
  use 'romgrk/barbar.nvim'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-fugitive'
  use 'akinsho/toggleterm.nvim'

  -- colorschemes
  use 'EdenEast/nightfox.nvim'
  use 'overcache/NeoSolarized'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-refactor' }
  use {
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag'
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'glepnir/lspsaga.nvim'

end)
