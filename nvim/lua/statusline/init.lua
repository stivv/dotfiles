local mode = require 'statusline.modes'
local git = require 'statusline.git'

vim.api.nvim_set_hl(0, 'PrimaryBlock', { bg = '#96CDFB', fg = '#161320' })
vim.api.nvim_set_hl(0, 'SecondaryBlock', { bg = '#161320', fg = '#96CDFB' })

local Statusline = {}

function Statusline.eval()
  return "%#PrimaryBlock# " .. mode() .. " %#SecondaryBlock#  פּ %-.39f   ".. git.git_branch .." %=  %Y  %l:%c [%p] "
end

return Statusline
