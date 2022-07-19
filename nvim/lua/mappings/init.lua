vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true, silent = true }

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

-- Telescope mappings
keymap('n', '<leader>ff', ':Telescope find_files<cr>', noremap)
keymap('n', '<leader>fh', ':Telescope help_tags<cr>', noremap)
keymap('n', '<leader>s', ':Telescope current_buffer_fuzzy_find<cr>', noremap)
keymap('n', '<leader>S', ':Telescope live_grep<cr>', noremap)
keymap('n', '<leader><leader>', ':Telescope buffers<cr>', noremap)

-- Nvim-tree mappings
keymap('n', 'nt', ':NeoTreeFloatToggle<cr>', noremap)
