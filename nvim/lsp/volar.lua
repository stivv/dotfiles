vim.lsp.config('volar', {
	filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },

	init_options = {
		vue = {
			hybridMode = false,
		},
		-- NOTE: This might not be needed. Uncomment if you encounter issues.
		typescript = {
			tsdk = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/typescript/lib",
		},
	},
})
