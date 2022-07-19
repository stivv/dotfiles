local Winbar = {}

vim.api.nvim_set_hl(0, 'WinbarPath', { bg = '#DDB6F2', fg = '#363636' })
vim.api.nvim_set_hl(0, 'WinbarModified', { bg = '#DDB6F2', fg = '#ff3838' })

function Winbar.eval()
  local filepath = vim.api.nvim_eval_statusline('%t', {}).str
  local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and '✪ ' or ''

  filepath = filepath:gsub('/', ' ᐉ ')
  return '%#WinbarPath# ' .. filepath .. ' %*%#WinbarModified#' .. modified .. '%* '
end

return Winbar
