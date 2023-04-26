local M = {}

M.init = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.eslint_d,
				-- null_ls.builtins.formatting.pint,
			},
		})
	end,
}

return M
