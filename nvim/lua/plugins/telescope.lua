return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = { border = false },
	},
	config = function()
		local builtin = require("telescope.builtin")

		local set = function(keys, action, desc)
			return vim.keymap.set("n", keys, action, { desc = desc })
		end

		-- Files
		set("<leader>ff", builtin.find_files, "Telescope find files")
		set("<leader>fg", builtin.live_grep, "Telescope live grep")
		set("<leader>fb", builtin.buffers, "Telescope buffers")
		set("<leader>fh", builtin.help_tags, "Telescope help tags")
		set("<leader>fr", builtin.oldfiles, "Telescope recent files")
		-- Lsp
		set("gd", builtin.lsp_definitions, "Lsp: definition")
		set("gr", builtin.lsp_references, "Lsp: references")
		set("gi", builtin.lsp_implementations, "Lsp: implementations")
	end,
}
