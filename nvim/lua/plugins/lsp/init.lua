return {
	{
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			'ray-x/lsp_signature.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/nvim-cmp',
		},
		config = function(plugin, options)
			local lspconfig = require 'plugins.lsp.lspconfig'
			lspconfig.setup(plugin, options)
			lspconfig.onAttach()
		end,
	},
	require 'plugins.lsp.cmp'.init,
	require 'plugins.lsp.null_ls'.init,
}
