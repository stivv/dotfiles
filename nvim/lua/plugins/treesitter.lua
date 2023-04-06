return {
	'nvim-treesitter/nvim-treesitter',
	event = 'BufReadPre',
	opts = {
		ensure_installed = {},
		highlight = {
			enable = true
		}
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
