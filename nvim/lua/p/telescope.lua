return function()
	local ok, telescope = pcall(require, 'telescope')

	if not ok then return end

	local actions = require('telescope.actions')

	function telescope_buffer_dir()
		return vim.fn.expand('%:p:h')
	end

	local fb_actions = require 'telescope'.extensions.file_browser.actions

	telescope.setup({
		defaults = {
			path_display = { truncate = 1 },
			prompt_prefix = '   ',
			selection_caret = '  ',
			layout_config = {
				prompt_position = 'top',
			},
			sorting_strategy = 'ascending',
			mappings = {
				i = {
					['<esc>'] = actions.close,
					['<C-Down>'] = actions.cycle_history_next,
					['<C-Up>'] = actions.cycle_history_prev,
				},
			},
			file_ignore_patterns = { '.git/' },
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			buffers = {
				previewer = false,
				layout_config = {
					width = 80,
				},
			},
			oldfiles = {
				prompt_title = 'History',
			},
			lsp_references = {
				previewer = false,
			},
		},
		extensions = {
			file_browser = {
				theme = 'dropdown',
				hijack_netrw = true,
				mappings = {
					['i'] = {
						['C-w'] = function() vim.cmd('normal vbd') end,
					},
					['n'] = {
						['N'] = fb_actions.create,
						['h'] = fb_actions.goto_parent_dir,
						['/'] = function()
							vim.cmd('startinsert')
						end
					}
				}
			}
		}

	})

	telescope.load_extension('fzf')
	telescope.load_extension('live_grep_args')

	telescope.load_extension('file_browser')

	local opts = { noremap = true, silent = true }


	vim.keymap.set('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
	vim.keymap.set('n', '<leader>F',
		[[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]], opts) -- luacheck: no max line length
	vim.keymap.set('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
	vim.keymap.set('n', '<leader>fg', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]], opts)
	vim.keymap.set('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
	vim.keymap.set('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

	-- Filebrowser
	vim.keymap.set('n', '<leader>nt',
		'<cmd>lua require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal", layout_config = { height = 40 } })<CR>'
		, opts)

end
