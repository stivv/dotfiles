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

-- Reselect visual selection after indenting
keymap('v', '<', '<gv', noremap)
keymap('v', '>', '>gv', noremap)

-- Quickly escape to normal mode
keymap('i', 'jj', '<esc>', noremap)

-- Switch to and edit files ( existing or not :) ) quickly
keymap('n', '<leader>gf', ':edit <cfile><cr>', {})

-- No yank on x
keymap('n', 'x', '"_x', noremap)

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', noremap)
