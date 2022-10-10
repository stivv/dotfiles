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

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.intelephense.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

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

local lspconfig_configs = require 'lspconfig.configs'
local lspconfig_util = require 'lspconfig.util'

local function on_new_config(new_config, new_root_dir)
	local function get_typescript_server_path(root_dir)
		local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
		return project_root and
				(lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
				or ''
	end

	if new_config.init_options
			and new_config.init_options.typescript
			and new_config.init_options.typescript.serverPath == ''
	then
		new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
	end
end

local volar_cmd = { 'vue-language-server', '--stdio' }
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

lspconfig_configs.volar_api = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		on_new_config = on_new_config,
		filetypes = { 'vue' },
		-- If you want to use Volar's Take Over Mode (if you know, you know)
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
		init_options = {
			typescript = {
				serverPath = ''
			},
			languageFeatures = {
				implementation = true, -- new in @volar/vue-language-server v0.33
				references = true,
				definition = true,
				typeDefinition = true,
				callHierarchy = true,
				hover = true,
				rename = true,
				renameFileRefactoring = true,
				signatureHelp = true,
				codeAction = true,
				workspaceSymbol = true,
				completion = {
					defaultTagNameCase = 'both',
					defaultAttrNameCase = 'kebabCase',
					getDocumentNameCasesRequest = false,
					getDocumentSelectionRequest = false,
				},
			}
		},
	}
}
lspconfig.volar_api.setup {}

lspconfig_configs.volar_doc = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		on_new_config = on_new_config,

		filetypes = { 'vue' },
		-- If you want to use Volar's Take Over Mode (if you know, you know):
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
		init_options = {
			typescript = {
				serverPath = ''
			},
			languageFeatures = {
				implementation = true, -- new in @volar/vue-language-server v0.33
				documentHighlight = true,
				documentLink = true,
				codeLens = { showReferencesNotification = true },
				-- not supported - https://github.com/neovim/neovim/pull/15723
				semanticTokens = false,
				diagnostics = true,
				schemaRequestService = true,
			}
		},
	}
}
lspconfig.volar_doc.setup {}

lspconfig_configs.volar_html = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		on_new_config = on_new_config,

		filetypes = { 'vue' },
		-- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
		--filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
		init_options = {
			typescript = {
				serverPath = ''
			},
			documentFeatures = {
				selectionRange = true,
				foldingRange = true,
				linkedEditingRange = true,
				documentSymbol = true,
				-- not supported - https://github.com/neovim/neovim/pull/13654
				documentColor = false,
				documentFormatting = {
					defaultPrintWidth = 100,
				},
			}
		},
	}
}
lspconfig.volar_html.setup {}

-- lspconfig.volar.setup {
-- 	on_attach = on_attach,
-- 	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
-- 	capabilities = capabilities,
-- }

-- npm i -g eslint
lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- npm install -g emmet-ls
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- npm i -g vscode-langservers-extracted
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { 'typescript', 'typescript.tsx' },
	cmd = { 'typescript-language-server', '--stdio' }
}
