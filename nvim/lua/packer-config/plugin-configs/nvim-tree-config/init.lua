require 'nvim-tree'.setup {
  diagnostics = {
    enable = true
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  view = {
    number = true,
    relativenumber = true,
  },
}
