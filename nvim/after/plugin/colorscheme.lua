local ok, onedark = pcall(require, 'onedark')

if not ok then return end

onedark.setup {
  style = 'darker',
  transparent = true,
  highlights = {
    StatusLine             = { fg = '$fg', bg = '$bg_d' },
    StatusLineNonText      = { fg = '$fg', bg = '$bg_d' },
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
