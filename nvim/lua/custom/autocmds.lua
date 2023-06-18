vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("UserBufEnter", {}),
  callback = function()
    vim.g.gitBranch =
        vim.fn.trim(vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " branch --show-current 2> /dev/null"))

    vim.g.statusMode = {
      ["n"] = "Normal",
      ["no"] = "Normal·Operator Pending",
      ["v"] = "Visual",
      ["V"] = "V·Line",
      [""] = "V·Block",
      ["s"] = "Select",
      ["S"] = "S·Line",
      [""] = "S·Block",
      ["i"] = "Insert",
      ["R"] = "Replace",
      ["Rv"] = "V·Replace",
      ["c"] = "Command",
      ["cv"] = "Vim Ex",
      ["ce"] = "Ex",
      ["r"] = "Prompt",
      ["rm"] = "More",
      ["r?"] = "Confirm",
      ["!"] = "Shell",
      ["t"] = "Terminal",
    }
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
