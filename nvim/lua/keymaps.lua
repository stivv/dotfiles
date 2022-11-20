-- Keymaps
local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true, silent = true }

vim.g.mapleader = ' '
-- Reselect visual selection after indenting
keymap('v', '<', '<gv', noremap)
keymap('v', '>', '>gv', noremap)

-- Quickly escape to normal mode
keymap('i', 'jj', '<esc>', noremap)

-- Switch to and edit files ( existing or not :) ) quickly
keymap('n', '<leader>gf', ':edit <cfile><cr>', {})

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', noremap)

-- Buffers
keymap('n', '<leader>l', ':bn<cr>', noremap)
keymap('n', '<leader>h', ':bp<cr>', noremap)
keymap('n', '<leader>bc', ':bd!<cr>', noremap)
keymap('n', '<leader>ba', ':%bd|e#|bd#<cr>', noremap)

-- Terminal
keymap('n', '<leader>tt', ':term<cr>', noremap)
keymap('t', '<C-t>', '<C-\\><C-n>', noremap)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, noremap)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, noremap)
vim.keymap.set('n', '<leader><leader>', builtin.buffers, noremap)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, noremap)
