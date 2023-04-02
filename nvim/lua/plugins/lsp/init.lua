return {
	'neovim/nvim-lspconfig',
	event = 'BufReadPre',
	dependencies = {
		{ 'williamboman/mason.nvim', config = true },
		'williamboman/mason-lspconfig.nvim',
		'ray-x/lsp_signature.nvim',
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function(plugin, options)
		local server = require("plugins.lsp.server")
		server.setup(plugin, options)
		server.onAttach()
	end,
}
