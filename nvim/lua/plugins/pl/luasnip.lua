return {
	config = function()
		local ok, ls = pcall(require, "luasnip")

		if not ok then return end
		--
		-- require("luasnip.loaders.from_snipmate").lazy_load()

		local types = require "luasnip.util.types"

		require("luasnip.loaders.from_vscode").lazy_load()

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

		ls.config.set_config({
			-- Keep around the last snippet
			history = true,
			-- if dynamic snippets exist, update as you type
			updateevents = "TextChanged,TextChangedI",
			-- Autosnippets
			enable_autosnippets = true,
			-- Highlights
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "<-", "Error" } },
					},
				},
			},
		})

		-- keymaps
		-- Expand current item and jump to next item within snippet
		vim.keymap.set({ "i", "s" }, "<a-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		-- Expand current item and jump to prev item within snippet
		vim.keymap.set({ "i", "s" }, "<a-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		-- Select within the options
		vim.keymap.set({ "i", "s" }, "<a-l>", function()
			if ls.choice_active() then
				ls.change_choice()
			end
		end, { silent = true })

		ls.add_snippets('php', {
			ls.parser.parse_snippet('class', 'class $1\n{\n    $0\n}'),
			ls.parser.parse_snippet('pubf', 'public function $1($2): $3\n{\n    $0\n}'),
			ls.parser.parse_snippet('prif', 'private function $1($2): $3\n{\n    $0\n}'),
			ls.parser.parse_snippet('prof', 'protected function $1($2): $3\n{\n    $0\n}'),
			ls.parser.parse_snippet('testt', 'public function test_$1()\n{\n    $0\n}'),
			ls.parser.parse_snippet('testa', '/** @test */\npublic function $1()\n{\n    $0\n}'),
		})

		ls.add_snippets('vue', {
			ls.parser.parse_snippet('import', "import $1 from '$0'"),
		})
	end
}
