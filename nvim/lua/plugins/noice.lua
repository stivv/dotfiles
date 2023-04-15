return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = { background_colour = "#000000" },
		},
	},
	event = "VeryLazy",
	opts = {
		lsp = {
			signature = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
	},
}
