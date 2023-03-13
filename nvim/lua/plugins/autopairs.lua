return {
	'windwp/nvim-autopairs',
	config = function()
		local ok, autopairs = pcall(require, 'nvim-autopairs')

		if not ok then return end

		autopairs.setup {
			disable_filetypes = { 'TelescopePrompt', 'vim' }
		}
	end
}
