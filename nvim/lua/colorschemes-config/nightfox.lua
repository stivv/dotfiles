local nf = require('nightfox')

vim.cmd('colorscheme nightfox')

nf.setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})
