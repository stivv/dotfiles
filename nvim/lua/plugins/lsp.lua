return {
	'neovim/nvim-lspconfig',
	event = 'BufEnter',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'ray-x/lsp_signature.nvim',
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		local ok, lspconfig = pcall(require, 'lspconfig')

		if not ok then return end

		local lsp_defaults = lspconfig.util.default_config

		lsp_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lsp_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)

		local servers = { 'volar', 'eslint', 'tsserver', 'bashls', 'dockerls', 'jsonls', 'emmet_ls', 'html', 'tailwindcss',
			'intelephense', 'rust_analyzer', 'lua_ls' }

		require('mason').setup()
		require('mason-lspconfig').setup { ensure_installed = servers }

		for _, server in ipairs(servers) do
			lspconfig[server].setup {
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

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

				require 'lsp_signature'.on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					handler_opts = {
						border = "rounded"
					}
				}, ev.buf)

				-- Formatting
				vim.keymap.set('n', '<space>f', function()
					vim.lsp.buf.format { async = true, filter = function(client) return client.name ~= 'volar' and
						client.name ~= 'tsserver' end }
				end, opts)

				vim.api.nvim_command [[ augroup Format ]]
				vim.api.nvim_command [[ autocmd! * <buffer> ]]
				vim.api.nvim_command [[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll ]]
				vim.api.nvim_command [[
					autocmd BufWritePre <buffer> lua vim.lsp.buf.format { async = false, filter = function(client) return client.name ~= 'volar' and client.name ~= 'tsserver' end }
				]]
				vim.api.nvim_command [[ augroup END ]]
			end,
		})

		local sign = function(opts)
			vim.fn.sign_define(opts.name, {
				texthl = opts.name,
				text = opts.text,
				numhl = ''
			})
		end

		sign({ text = '', name = 'DiagnosticSignError' })
		sign({ text = '', name = 'DiagnosticSignWarn' })
		sign({ text = '', name = 'DiagnosticSignInfo' })
		sign({ text = '', name = 'DiagnosticSignHint' })

		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = false,
			float = {
				border = 'rounded',
				source = 'always',
			},
		})

		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{ border = 'rounded' }
		)

		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = 'rounded' }
		)
	end
}
