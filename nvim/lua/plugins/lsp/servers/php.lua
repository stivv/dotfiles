return {
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { 'php', 'phpdoc' })
		end,
	},
	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				intelephense = {
				}
			}
		}
	}
}
