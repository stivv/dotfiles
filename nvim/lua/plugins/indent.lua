return {
	'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
	--   'tpope/vim-sleuth',                    -- Detect tabstop and shiftwidth automatically
	config = function()
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		local ok, indent = pcall(require, 'indent_blankline')

		if not ok then return end

		indent.setup {
			char = '┊',
			show_trailing_blankline_indent = false,
		}
	end
}
