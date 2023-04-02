return {
	{
		'nvim-treesitter/nvim-treesitter',
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { 'vue', 'javascript', 'html', 'css', 'typescript' })
		end,
	},
	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				volar = {
					filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
				},
				eslint = {
					on_attach = function(_, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				}
			},
		},
	}
}
