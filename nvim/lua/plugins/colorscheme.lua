return {
	"sainnhe/edge",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
		vim.cmd([[
			let g:edge_style = 'neon'
			let g:edge_better_performance = 1
			let g:edge_colors_override = {'bg0': ['#0d1117', '234'], 'bg2': ['#282828', '235']}
			colorscheme edge
		]])
	end,
}
