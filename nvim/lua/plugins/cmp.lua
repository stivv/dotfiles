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

		local select_opts = { behavior = cmp.SelectBehavior.Select }

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-e>'] = cmp.mapping.abort(),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<C-f>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<C-b>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<Tab>'] = cmp.mapping(function(fallback)
					local col = vim.fn.col('.') - 1

					if cmp.visible() then
						cmp.select_next_item(select_opts)
					elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
						fallback()
					else
						cmp.complete()
					end
				end, { 'i', 's' }),

				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(select_opts)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'luasnip',                keyword_length = 2 },
				{ name = 'nvim_lsp',               keyword_length = 1 },
				{ name = 'buffer',                 keyword_length = 3 },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'path' },
			},
			window = {
				documentation = cmp.config.window.bordered()
			},
			formatting = {
				format = require('lspkind').cmp_format({
					with_text = true,
				}),
				fields = { 'menu', 'abbr', 'kind' }
			},
			experimental = {
				ghost_text = true,
			},
		}
	end
}
