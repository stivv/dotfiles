-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Easy escape
vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', { silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Buffers
vim.keymap.set("n", "<leader>h", "<cmd>bp<cr>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>bn<cr>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>ba", ":%bd|e#|bd#<cr>", { desc = "Close all buffers" })
