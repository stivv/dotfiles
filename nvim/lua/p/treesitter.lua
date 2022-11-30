return function()
	local ok, ts = pcall(require, 'nvim-treesitter.configs')

	if not ok then return end

	ts.setup {
		ensure_installed = { 'lua', 'rust', 'bash', 'css', 'dockerfile', 'html', 'json', 'javascript', 'php', 'typescript',
			'vue' },


		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}
end
