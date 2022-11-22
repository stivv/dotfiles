local ok, lspconfig = pcall(require, 'lspconfig')

if not ok then return end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

	-- Formatting
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_command [[ augroup Format ]]
		vim.api.nvim_command [[ autocmd! * <buffer> ]]
		vim.api.nvim_command [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
		vim.api.nvim_command [[ augroup END ]]
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

local servers = { 'volar', 'eslint', 'tsserver', 'jsonls', 'emmet_ls', 'html', 'tailwindcss', 'intelephense',
	'rust_analyzer', 'sumneko_lua' }

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

require 'lsp_signature'.setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded"
	}
})
