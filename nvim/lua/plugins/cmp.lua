return {
	'hrsh7th/nvim-cmp',
	event = "InsertEnter",
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
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

		local cmp_kinds = {
			Text = '  ',
			Method = '  ',
			Function = '  ',
			Constructor = '  ',
			Field = '  ',
			Variable = '  ',
			Class = '  ',
			Interface = '  ',
			Module = '  ',
			Property = '  ',
			Unit = '  ',
			Value = '  ',
			Enum = '  ',
			Keyword = '  ',
			Snippet = '  ',
			Color = '  ',
			File = '  ',
			Reference = '  ',
			Folder = '  ',
			EnumMember = '  ',
			Constant = '  ',
			Struct = '  ',
			Event = '  ',
			Operator = '  ',
			TypeParameter = '  ',
		}

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
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					local col = vim.fn.col('.') - 1
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end

					if cmp.visible() then
						cmp.select_next_item()
					elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
						fallback()
					else
						cmp.complete()
					end
				end, { 'i', 's' }),

				['<S-Tab>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'luasnip', },
				{ name = 'nvim_lsp', },
				{ name = 'buffer', },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'path' },
			},
			formatting = {
				format = function(_, vim_item)
					vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
					return vim_item
				end,
			},
			experimental = {
				ghost_text = true,
			},
		}

		vim.cmd [[
			" gray
			highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
			" blue
			highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
			highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
			" light blue
			highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
			highlight! link CmpItemKindInterface CmpItemKindVariable
			highlight! link CmpItemKindText CmpItemKindVariable
			" pink
			highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
			highlight! link CmpItemKindMethod CmpItemKindFunction
			" front
			highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
			highlight! link CmpItemKindProperty CmpItemKindKeyword
			highlight! link CmpItemKindUnit CmpItemKindKeyword
		]]
	end
}
