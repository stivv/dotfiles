return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make', cond = vim.fn.executable 'make' == 1 },
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`

		local ok, telescope = pcall(require, 'telescope')

		if not ok then return end

		local actions = require('telescope.actions')

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
					cwd_to_path = true,
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

		-- Enable telescope fzf native, if installed
		pcall(telescope.load_extension, 'fzf')

		-- To get telescope-file-browser loaded and working with telescope,
		pcall(telescope.load_extension, 'file_browser')

		local builtin = require('telescope.builtin')

		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer]' })

		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>fh', builtin.oldfiles, { desc = '[?] Find recently opened files' })
		vim.keymap.set('n', '<leader>ft', builtin.help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

		-- File browser
		vim.keymap.set('n', '<leader>nt',
			'<cmd>Telescope file_browser path=%:p:h previewer=false initial_mode=normal height=80 <cr>', { noremap = true })
	end
}
