-- Set lualine as statusline
-- See `:help lualine.txt`
local ok, lualine = pcall(require, 'lualine')

if not ok then return end

local separator = { '"▏"', color = 'StatusLineNonText' }

lualine.setup({
  options = {
    section_separators = '',
    component_separators = '',
    globalstatus = true,
    theme = {
      normal = {
        a = 'StatusLine',
        b = 'StatusLine',
        c = 'StatusLine',
      },
    },
    symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  },
  sections = {
    lualine_a = {
      'mode',
      separator,
    },
    lualine_b = {
      'filename',
    },
    lualine_c = {
      separator,
      'branch',
      'diff',
      separator,
      '"  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
      separator,
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_x = {
      'filetype',
      separator,
    },
    lualine_y = {
      'fileformat',
      'encoding',
      separator,
    },
    lualine_z = {
      'location',
      'progress',
    },
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
})
