return {
	'karb94/neoscroll.nvim',
	config = function()
		local ok, ns = pcall(require, 'neoscroll')

		if not ok then return end

		ns.setup {}
	end
}
