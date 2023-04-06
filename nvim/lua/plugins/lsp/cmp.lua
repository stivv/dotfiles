local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local M = {}

M.init = {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

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


		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'path' },
			}),
			mapping = cmp.mapping.preset.insert {
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm { select = true },
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
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
		})

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

return M
