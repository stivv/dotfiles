return {
	'numToStr/Comment.nvim',
	event = 'BufReadPre',
	config = function()
		-- Enable Comment.nvim
		local ok, comment = pcall(require, 'Comment')

		if not ok then return end

		comment.setup()
	end
}
