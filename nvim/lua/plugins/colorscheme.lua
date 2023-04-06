return {
	'folke/tokyonight.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require 'tokyonight'.setup {
			transparent = true,
			on_highlights = function(hl, c)
				local prompt = "#2d3149"
				hl.TelescopeNormal = {
					bg = c.bg_dark,
					fg = c.fg_dark,
				}
				hl.TelescopeBorder = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePromptNormal = {
					bg = c.bg_dark,
				}
				hl.TelescopePromptBorder = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePromptTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopePreviewTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
				hl.TelescopeResultsTitle = {
					bg = c.bg_dark,
					fg = c.bg_dark,
				}
			end,
		}
		vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
		vim.cmd [[ colorscheme tokyonight ]]
	end
}
