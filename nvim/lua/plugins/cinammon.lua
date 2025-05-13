return {
	"declancm/cinnamon.nvim",
	version = "*",
	opts = {
		-- Enable all provided keymaps
		keymaps = {
			basic = true,
			extra = true,
		},
		-- Only scroll the window
		options = { mode = "window" },
	},
}
