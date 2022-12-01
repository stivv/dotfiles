return function()

	local ok, lspconfig = pcall(require, 'lspconfig')

	if not ok then return end

	require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

	-- vim.lsp.set_log_level("debug")

	vim.diagnostic.config({
		virtual_text = true,
		severity_sort = true,
		float = {
			source = true,
			focus = false,
			format = function(diagnostic)
				if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
					return string.format('%s: %s', diagnostic.user_data.lsp.code, diagnostic.message)
				end
				return diagnostic.message
			end,
		},
	})

	local on_attach = function(client, bufnr)
		vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

		vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>')
		vim.keymap.set('v', '<leader>ca', ':CodeActionMenu<CR>')

		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr })
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = bufnr })
		vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = bufnr })


		require 'lsp_signature'.on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
				border = "rounded"
			}
		}, bufnr)

		-- Formatting
		if (client.name ~= 'volar' and client.server_capabilities.documentFormattingProvider) then
			vim.api.nvim_command [[ augroup Format ]]
			vim.api.nvim_command [[ autocmd! * <buffer> ]]
			vim.api.nvim_command [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
			vim.api.nvim_command [[ augroup END ]]
		end

		if client.name == 'eslint' then
			vim.api.nvim_command [[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll ]]
		end
	end

	-- nvim-cmp supports additional completion capabilities
	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

	local servers = { 'volar', 'eslint', 'tsserver', 'bashls', 'dockerls', 'jsonls', 'emmet_ls', 'html', 'tailwindcss',
		'intelephense',
		'rust_analyzer', 'sumneko_lua', 'sqls' }

	for _, server in ipairs(servers) do
		lspconfig[server].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						-- Make the server aware of nvim runtime files
						library = vim.api.nvim_get_runtime_file('', true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				}
			}
		}
	end

	vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
	vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
	vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
	vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

	-- suppress error messages from lang servers
	-- vim.notify = function(msg, log_level, _)
	--   if msg:match 'exit code' then
	--     return
	--   end
	--   if log_level == vim.log.levels.ERROR then
	--     vim.api.nvim_err_writeln(msg)
	--   else
	--     vim.api.nvim_echo({ { msg } }, true, {})
	--   end
	-- end
end
