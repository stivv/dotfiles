local ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not ok then return end

treesitter.setup {
	highlight = {
		enable = true,
		disable = {}
	},
	indent = {
		enable = true,
		disable = {}
	},
	ensure_installed = { 'lua', 'json', 'css', 'c', 'rust', 'javascript', 'typescript', 'vue', 'php', 'markdown', 'html' },
	autotag = {
		enable = true
	},
}
