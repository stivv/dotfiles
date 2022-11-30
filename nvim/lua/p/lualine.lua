return function()
	local separator = { '"▏"', color = 'StatusLineNonText' }

	require('lualine').setup({
		options = {
			section_separators = '',
			component_separators = '',
			globalstatus = true,
			theme = {
				normal = {
					a = 'StatusLine',
					b = 'StatusLine',
					c = 'StatusLine',
				},
			},
		},
		sections = {
			lualine_a = {
				'mode',
				separator,
			},
			lualine_b = {
				'filename',
			},
			lualine_c = {
				separator,
				'branch',
				'diff',
				separator,
				'"  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
				separator,
				{ 'diagnostics', sources = { 'nvim_diagnostic' } },
			},
			lualine_x = {
				'filetype',
				separator,
			},
			lualine_y = {
				'fileformat',
				'encoding',
				separator,
			},
			lualine_z = {
				'location',
				'progress',
			},
		},
	})
end
