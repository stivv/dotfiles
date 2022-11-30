local ok, cmp = pcall(require, 'cmp')

if not ok then return end

local lspkind = require('lspkind')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,longest,preview'

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			-- menu = {
			-- 	nvim_lsp = '[LSP]',
			-- 	nvim_lua = '[Lua]',
			-- 	buffer = '[BUF]',
			-- },
		}),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})
