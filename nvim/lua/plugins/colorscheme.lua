return {
	"sainnhe/edge",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
		vim.cmd([[
			let g:edge_style = 'neon'
			let g:edge_better_performance = 1
			let g:edge_colors_override = {'bg0': ['#0d1117', '234'], 'bg1': ['#161b22', '235'], 'bg2': ['#161b22', '235']}
			colorscheme edge
		]])
	end,
}
