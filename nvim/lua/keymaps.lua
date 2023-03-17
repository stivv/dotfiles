-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)

-- Keymaps
local noremap = { noremap = true, silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Exit insert mode remap
vim.keymap.set('i', 'jj', '<ESC>')

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', noremap)
vim.keymap.set('v', '>', '>gv', noremap)

-- Switch to and edit files ( existing or not :) ) quickly
vim.keymap.set('n', '<leader>gf', ':edit <cfile><cr>', {})

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', noremap)

-- Terminal
vim.keymap.set('n', '<leader>tt', ':term<cr>', noremap)
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>', noremap)

-- Buffers
vim.keymap.set('n', '<leader>l', ':bn<cr>', noremap)
vim.keymap.set('n', '<leader>h', ':bp<cr>', noremap)
vim.keymap.set('n', '<leader>bc', ':bd!<cr>', noremap)
vim.keymap.set('n', '<leader>ba', ':%bd|e#|bd#<cr>', noremap)
