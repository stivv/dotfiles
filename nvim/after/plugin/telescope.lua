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
    }
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
}

telescope.load_extension('file_browser')

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ff',
  '<cmd>lua require("telescope.builtin").find_files({ no_ignore = false, hidden = true })<CR>', opts)
vim.keymap.set('n', '<leader>S', '<cmd>lua require("telescope.builtin").live_grep()<CR>', opts)
vim.keymap.set('n', '<leader><leader>', '<cmd>lua require("telescope.builtin").buffers()<CR>', opts)
vim.keymap.set('n', '<leader>ht', '<cmd>lua require("telescope.builtin").help_tags()<CR>', opts)
vim.keymap.set('n', '<leader>tr', '<cmd>lua require("telescope.builtin").resume()<CR>', opts)
vim.keymap.set('n', '<leader>td', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', opts)

-- Filebrowser
vim.keymap.set('n', '<leader>nt',
  '<cmd>lua require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal", layout_config = { height = 40 } })<CR>'
  , opts)
