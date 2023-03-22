return {
	'hrsh7th/nvim-cmp',
	event = "InsertEnter",
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'onsails/lspkind.nvim',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		-- nvim-cmp setup
		local ok, cmp = pcall(require, 'cmp')

		if not ok then return end

		local luasnip = require('luasnip')

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'luasnip' },
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'buffer' },
				{ name = 'path' },
			},
			formatting = {
				format = require('lspkind').cmp_format({
					with_text = true,
					--   menu = {
					--     nvim_lsp = '[LSP]',
					--     nvim_lua = '[Lua]',
					--     buffer = '[BUF]',
					--     luasnip = '[SNIP]',
					--     path = '[PATH]',
					--   },
				}),
			},
			experimental = {
				ghost_text = true,
			},
		}
	end
}