-- help file open in vertical split
vim.cmd([[ augroup vertical_help ]])
vim.cmd([[ autocmd! ]])
vim.cmd([[ autocmd FileType help wincmd L ]])
vim.cmd([[ augroup END ]])

-- Open terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert', pattern = '*' })

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = '*',
	command = 'set nopaste'
})
