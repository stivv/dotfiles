return {
	'navarasu/onedark.nvim',
	lazy = false,   -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local ok, onedark = pcall(require, 'onedark')

		if not ok then return end

		onedark.setup {
			style = 'darker',
			transparent = true,
			colors = {
				black = "#000000",
				black1 = "#090a0c",
			},
			highlights = {
				StatusLine             = { fg = '$fg', bg = '$black1' },
				StatusLineNonText      = { fg = '$fg', bg = '$black1' },
				Floaterm               = { fg = '$fg', bg = '$black1' },
				FloatermBorder         = { fg = '$black1', bg = '$black1' },
				TelescopePromptBorder  = { fg = '$black1', bg = '$black1' },
				TelescopePromptNormal  = { fg = '$fg', bg = '$black1' },
				TelescopePromptTitle   = { fg = '$green' },
				TelescopeResultsBorder = { fg = '$black1', bg = '$black1' },
				TelescopeResultsNormal = { fg = '$fg', bg = '$black1' },
				TelescopeResultsTitle  = { fg = '$green' },
				TelescopePreviewBorder = { fg = '$black1', bg = '$black1' },
				TelescopePreviewNormal = { fg = '$fg', bg = '$black1' },
				TelescopePreviewTitle  = { fg = '$green' },
				['@keyword']           = { fg = '$red' },
				['@string']            = { fg = '$green' },
				['@function']          = { fg = '$blue', fmt = 'bold' },
				['@function.builtin']  = { fg = '$blue' },
				['@tag']               = { fg = '$red' },
				['@tag.attribute']     = { fg = '$purple' },
				['@tag.delimiter']     = { fg = '$blue' },
			}
		}


		onedark.load()
	end
}
