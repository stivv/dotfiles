-- Ensure packer is installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

require('generalsettings')
require('keymappings')
require('plugins')

-- Plugins configs
require('plugs.telescope')
require('plugs.lualine')
require('plugs.bufferline')
require('plugs.nvim-tree')
require('plugs.gitsigns')

require('plugs.treesitter')
require('plugs.comments')
require('plugs.autopairs')

require('plugs.lsp-config.language-servers')
require('plugs.lsp-config.nvim-cmp')
require('plugs.lsp-config.lspsaga')
