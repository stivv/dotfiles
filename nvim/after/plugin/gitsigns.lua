-- Gitsigns
-- See `:help gitsigns.txt`
local ok, gs = pcall(require, 'gitsigns')

if not ok then return end

gs.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

