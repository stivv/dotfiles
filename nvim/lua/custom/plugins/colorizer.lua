return {
  'norcalli/nvim-colorizer.lua',
  configs = function()
    require'colorizer'.setup({
      buftypes = {
        "*",
        -- exclude prompt and popup buftypes from highlight
        "!prompt",
        "!popup",
      }
    })
  end,
}
