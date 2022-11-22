local keymap = vim.keymap

keymap.set('i', 'jj', '<ESC>')

-- No yank on x
keymap.set('n', 'x', '"_x')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')
