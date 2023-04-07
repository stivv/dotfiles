return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			transparent = true,
			on_highlights = function(hl, c)
				c.bg_dark = "#0c0c0d"
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
				hl.StatusLine = {
					bg = "#000000",
				}
			end,
		})
		vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
		vim.cmd([[ colorscheme tokyonight ]])
	end,
}
