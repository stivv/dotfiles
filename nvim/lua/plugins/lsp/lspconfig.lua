local M = {}

M.setup = function(_, opts)
	local ok, lspconfig = pcall(require, "lspconfig")
	if not ok then
		return
	end

	local mlsp, masonlsp = pcall(require, "mason-lspconfig")
	if not mlsp then
		return
	end

	local servers = opts.servers

	masonlsp.setup({ ensure_installed = vim.tbl_keys(servers or {}) })
	masonlsp.setup_handlers({
		function(server)
			local server_opts = servers[server]

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			server_opts.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			lspconfig[server].setup(server_opts)
		end,
	})

	local sign = function(signs)
		vim.fn.sign_define(signs.name, { texthl = signs.name, text = signs.text, numhl = "" })
	end

	sign({ text = "", name = "DiagnosticSignError" })
	sign({ text = "", name = "DiagnosticSignWarn" })
	sign({ text = "", name = "DiagnosticSignInfo" })
	sign({ text = "", name = "DiagnosticSignHint" })
end

M.onAttach = function()
	-- Global mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>", opts)
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

			require("lsp_signature").on_attach({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = false,
				},
			}, ev.buf)

			-- Formatting
			if vim.lsp.buf_get_clients()[ev.data.client_id].name ~= "volar" then
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({
						async = true,
						filter = function(client)
							return client.name ~= "volar" and client.name ~= "eslint"
						end,
					})
				end, opts)

				local formatGrp = vim.api.nvim_create_augroup("Format", { clear = true })
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = ev.buf,
					group = formatGrp,
					command =
					"lua vim.lsp.buf.format { async = false, filter = function(client) return client.name ~= 'volar' and client.name ~= 'eslint' end }",
				})
			end
		end,
	})
end

return M
