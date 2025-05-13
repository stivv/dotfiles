return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"stevearc/conform.nvim",
	},
	opts = {},
	config = function(_, opts)
		vim.diagnostic.config({ virtual_text = true })

		local servers = {
			"lua_ls",
			"stylua",
			"volar",
			"emmet_ls",
			"tailwindcss",
			"prettier",
			"eslint",
			"intelephense",
			"phpactor",
			"pint",
		}

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = servers })

		for _, server in pairs(servers) do
			vim.lsp.enable(server)
		end

		-- Formatting
		require("conform").setup({
			notify_on_error = false,
			format_on_save = function(bufnr)
				return {
					timeout_ms = 2500,
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				vue = { "prettier", "prettierd", stop_after_first = true },
				javascript = { "prettier", "prettierd", stop_after_first = true },
			},
		})
	end,
}
