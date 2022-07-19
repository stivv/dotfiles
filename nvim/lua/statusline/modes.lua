local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'N·OPERATOR PENDING',
  ['v'] = 'VISUAL',
  ['V'] = 'V·LINE',
  [''] = 'V·BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S·LINE',
  [''] = 'S·BLOCK',
  ['i'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'V·REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL'
}

local function mode()
  local m = vim.api.nvim_get_mode().mode
  if mode_map[m] == nil then return m end
  return mode_map[m]
end

return mode
