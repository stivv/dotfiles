local mapkey = function(mode, key, cmd, opts)
	return vim.keymap.set(mode, key, cmd, opts)
end

mapkey('i', 'jj', '<Esc>', { desc = 'Faster escape' })
mapkey('n', '<C-a>', 'ggVG', { desc = 'Select all' })

mapkey('n', '<leader>h', '<cmd>bNext<cr>', { desc = 'Go to next buffer' })
mapkey('n', '<leader>l', '<cmd>bprev<cr>', { desc = 'Go to previous buffer' })
mapkey('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = 'Close current buffer' })
