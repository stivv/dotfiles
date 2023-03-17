return {
	'voldikss/vim-floaterm',
	cmd = 'FloatermToggle',
	keys = {
		{ '<c-\\>', '<cmd>FloatermToggle scratch<CR>', desc = 'Toggle floaterm' },
	},
	config = function()
		local opts = { noremap = true, silent = true }
		vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>:FloatermToggle scratch<CR>', opts)
		vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:FloatermToggle scratch<CR>', opts)

		vim.g.floaterm_gitcommit = 'floaterm'
		vim.g.floaterm_autoinsert = 1
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floaterm_wintitle = 0
	end
}
