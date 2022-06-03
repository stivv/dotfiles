require 'toggleterm'.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  direction = "float",
  shade_terminals = true,
  shade_filetypes = {},
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}
