return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { 'html', 'javascript', 'typescript', 'vue', })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				volar = { settings = {} },
				eslint = { settings = {} },
				html = { settings = {} },
				emmet_ls = { settings = {} },
			},
			setup = {},
		},
	},
}
