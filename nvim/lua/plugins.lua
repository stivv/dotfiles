require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- plugins stuff
    use 'overcache/NeoSolarized'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "jose-elias-alvarez/null-ls.nvim"
    -- use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind.nvim'
    use 'numToStr/Comment.nvim'
    use 'tpope/vim-fugitive'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

end)

-- Plugins configs
require('plugs.telescope')
require('plugs.lualine')
require('plugs.treesitter')
require('plugs.nvimcmp')
require('plugs.comments')
require('plugs.nvim-tree')
require('plugs.null-ls')
