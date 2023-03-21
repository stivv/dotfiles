return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { 'javascript', 'typescript' })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				eslint = { settings = {} },
			},
			setup = {},
		},
	},
}
