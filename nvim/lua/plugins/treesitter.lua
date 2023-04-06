return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'BufReadPre',
		dependencies = {
			'windwp/nvim-ts-autotag',
		},
		opts = {
			ensure_installed = {},
			highlight = {
				enable = true
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable one of the mappings
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			autotag = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	}
}
