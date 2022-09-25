local ok, ls = pcall(require, "luasnip")

if not ok then return end

local types = require "luasnip.util.types"

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

ls.config.set_config({
  -- Keep around the last snippet
  history = true,

  -- if dynamic snippets exist, update as you type
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets
  enable_autosnippets = true,

  -- Highlights
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
})

-- keymaps
-- Expand current item and jump to next item within snippet
vim.keymap.set({ "i", "s" }, "<a-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Expand current item and jump to prev item within snippet
vim.keymap.set({ "i", "s" }, "<a-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- Select within the options
vim.keymap.set({ "i", "s" }, "<a-l>", function()
  if ls.choice_active() then
    ls.change_choice()
  end
end, { silent = true })
