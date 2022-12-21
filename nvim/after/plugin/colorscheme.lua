local ok, onedark = pcall(require, 'onedark')

if not ok then return end

onedark.setup {
  style = 'darker',
  highlights = {
    Floaterm               = { fg = '$fg', bg = '$bg1' },
    FloatermBorder         = { fg = '$bg1', bg = '$bg1' },
    TelescopePromptBorder  = { fg = '$bg1', bg = '$bg1' },
    TelescopePromptNormal  = { fg = '$fg', bg = '$bg1' },
    TelescopePromptTitle   = { fg = '$green' },
    TelescopeResultsBorder = { fg = '$bg1', bg = '$bg1' },
    TelescopeResultsNormal = { fg = '$fg', bg = '$bg1' },
    TelescopeResultsTitle  = { fg = '$green' },
    TelescopePreviewBorder = { fg = '$bg1', bg = '$bg1' },
    TelescopePreviewNormal = { fg = '$fg', bg = '$bg1' },
    TelescopePreviewTitle  = { fg = '$green' },
    ['@keyword']           = { fg = '$red' },
    ['@string']            = { fg = '$green' },
    ['@function']          = { fg = '$blue', fmt = 'bold' },
    ['@function.builtin']  = { fg = '$blue' },
    ['@tag']               = { fg = '$red' },
    ['@tag.attribute']     = { fg = '$purple' },
    ['@tag.delimiter']     = { fg = '$blue' },
  }
}


onedark.load()

-- Make the StatusLineNonText background the same as StatusLine
vim.api.nvim_set_hl(0, 'StatusLineNonText', {
  fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
  bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
})
