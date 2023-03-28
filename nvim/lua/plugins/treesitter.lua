return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = 'BufReadPre',
	dependencies = {'windwp/nvim-ts-autotag'},
	config = function()
		require'nvim-treesitter.configs'.setup {
			ensure_installed = { 'lua', 'luadoc', 'vue', 'html', 'javascript', 'css' },
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
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			}
		}
	end
}
