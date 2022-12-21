-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
local ok, indent = pcall(require, 'indent_blankline')

if not ok then return end

indent.setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

