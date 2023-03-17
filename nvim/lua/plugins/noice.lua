return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = { signature = { enabled = false } },
			})
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
}
