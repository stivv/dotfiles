local noremap = { noremap = true, silent = true }
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local mapkey = function(mode, key, cmd, opts)
	return vim.keymap.set(mode, key, cmd, opts)
end

mapkey('i', 'jj', '<Esc>', { desc = 'Faster escape' })
mapkey('n', '<C-a>', 'ggVG', { desc = 'Select all' })

mapkey('n', '<leader>h', '<cmd>bNext<cr>', { desc = 'Go to next buffer' })
mapkey('n', '<leader>l', '<cmd>bprev<cr>', { desc = 'Go to previous buffer' })
mapkey('n', '<leader>bc', '<cmd>bdelete<cr>', { desc = 'Close current buffer' })
mapkey('n', '<leader>ba', ':%bd|e#|bd#<cr>', noremap)

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', noremap)
vim.keymap.set('v', '>', '>gv', noremap)
