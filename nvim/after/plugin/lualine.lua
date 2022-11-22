local ok, lualine = pcall(require, 'lualine')

if not ok then return end

lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'onedark',
		disabled_filetypes = {},
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_c = { {
			'filename',
			file_status = true,
			path = 0 -- just filename
		} },
		lualine_b = { 'branch' },
		lualine_x = {
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
			},
			'encoding',
			'filetype',
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { {
			'filename',
			file_status = true,
			path = 1
		} },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	}
}
