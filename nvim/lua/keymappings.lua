vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true }

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
keymap('i', 'jj', '<esc>', {})

-- Switch to and edit files ( existing or not :) ) quickly
keymap('n', 'gf', ':edit <cfile><cr>', {})

-- Telescope mappings
keymap('n', 'ff', ':Telescope find_files<cr>', {})
keymap('n', 'lg', ':Telescope live_grep<cr>', {})

-- Nvim-tree mappings
keymap('n', 'nt', ':NvimTreeToggle<cr>', {})

-- Bufferline mappings
keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<cr>', {})
keymap('n', '<leader>cn', ':BufferLineCycleNext<cr>', {})
keymap('n', '<leader>cp', ':BufferLineCyclePrev<cr>', {})
