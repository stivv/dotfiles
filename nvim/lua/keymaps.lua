-- Keymaps
local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true, silent = true }

-- Leader key to spacebar
vim.g.mapleader = " "

-- Quickly edit init.lua file
keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua', {})

-- Quicker switching between windows
keymap('n', '<c-h>', '<c-w>h', noremap)
keymap('n', '<c-j>', '<c-w>j', noremap)
keymap('n', '<c-k>', '<c-w>k', noremap)
keymap('n', '<c-l>', '<c-w>l', noremap)

keymap('i', 'jj', '<ESC>', noremap)

-- Reselect visual selection after indenting
keymap('v', '<', '<gv', noremap)
keymap('v', '>', '>gv', noremap)

-- Switch to and edit files ( existing or not :) ) quickly
keymap('n', '<leader>gf', ':edit <cfile><cr>', {})

-- Select all
keymap('n', '<C-a>', 'ggVG', noremap)

-- Terminal
keymap('n', '<leader>tt', ':term<cr>', noremap)
keymap('t', '<C-t>', '<C-\\><C-n>', noremap)

-- Buffers
keymap('n', '<leader>l', ':bn<cr>', noremap)
keymap('n', '<leader>h', ':bp<cr>', noremap)
keymap('n', '<leader>bc', ':bd!<cr>', noremap)
keymap('n', '<leader>ba', ':%bd|e#|bd#<cr>', noremap)
