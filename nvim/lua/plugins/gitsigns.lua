return {
	-- 'tpope/vim-fugitive',
	-- 'tpope/vim-rhubarb',
	'lewis6991/gitsigns.nvim',
	event = 'BufReadPost',
	config = function()
		-- Gitsigns
		-- See `:help gitsigns.txt`
		local ok, gs = pcall(require, 'gitsigns')

		if not ok then return end

		gs.setup {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		}
	end
}
