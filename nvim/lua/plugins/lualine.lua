local separator = { '"▏"', color = 'StatusLineNonText' }
return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	opts = function()
		return {
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
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
			},
			sections = {
				lualine_b = {
					separator,
					'branch',
					'diff',
				},
				lualine_c = {},
				lualine_x = {
					'"  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
					{ 'diagnostics', sources = { 'nvim_diagnostic' } },
					separator,
					'filename',
					separator,
				},
				lualine_y = {},
				lualine_z = {
					'location',
					'progress',
				},
			}
		}
	end
}
