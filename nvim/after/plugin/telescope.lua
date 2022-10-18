local ok, telescope = pcall(require, 'telescope')

if not ok then return end

local actions = require 'telescope.actions'

function telescope_buffer_dir()
	return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
	defaults = {
		mappings = {
			n = {
				['q'] = actions.close
			}
		},
		initial_mode = 'insert',
		hidden = true,
		file_ignore_patterns = { '.git/', 'node_modules/' }
	},
	pickers = { find_files = { hidden = true } },
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
}

telescope.load_extension('file_browser')

local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
vim.keymap.set('n', '<leader><leader>', builtin.buffers, opts)

-- Filebrowser
vim.keymap.set('n', '<leader>nt',
	'<cmd>lua require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal", layout_config = { height = 40 } })<CR>'
	, opts)
