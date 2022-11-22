local ok, lspsaga = pcall(require, 'lspsaga')

if not ok then return end

lspsaga.init_lsp_saga {
	server_filetype_map = {}
}

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set('n', '<leader>gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
vim.keymap.set('n', '<leader>gp', '<Cmd>Lspsaga preview_definition<cr>', opts)
vim.keymap.set('n', '<leader>gr', '<Cmd>Lspsaga rename<cr>', opts)
