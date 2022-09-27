local ok, lspsaga = pcall(require, 'lspsaga')

if not ok then return end

lspsaga.init_lsp_saga {
	server_filetype_map = {}
}

local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)

vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<cr>', opts)

vim.keymap.set('n', '<leader>e', '<Cmd>Lspsaga show_line_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>ga', '<Cmd>Lspsaga code_action<cr>', opts)
vim.keymap.set('n', '<leader>gd', '<Cmd>Lspsaga peek_definition<cr>', opts)
vim.keymap.set('n', '<leader>gf', '<Cmd>Lspsaga lsp_finder<cr>', opts)
vim.keymap.set('n', '<leader>gr', '<Cmd>Lspsaga rename<cr>', opts)
