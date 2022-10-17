local ok, lspconfig = pcall(require, 'lspconfig')

if not ok then return end

local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	print(vim.inspect(client.server_capabilities))

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

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"detail",
		"documentation",
		"additionalTextEdits",
	},
}

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = { 'volar', 'eslint', 'jsonls', 'emmet_ls', 'html', 'tailwindcss', 'rust_analyzer', 'intelephense' }

for _, server in pairs(servers) do
	lspconfig[server].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

lspconfig.sumneko_lua.setup {
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
