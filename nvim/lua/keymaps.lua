-- Keymaps
local noremap = { noremap = true, silent = true }
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local mapkey = function(mode, key, cmd, opts)
	return vim.keymap.set(mode, key, cmd, opts)
end

mapkey("i", "jj", "<Esc>", { desc = "Faster escape" })
mapkey("n", "<C-a>", "ggVG", { desc = "Select all" })
mapkey("n", "<leader>h", "<cmd>bp<cr>", { desc = "Go to previous buffer" })
mapkey("n", "<leader>l", "<cmd>bn<cr>", { desc = "Go to next buffer" })
mapkey("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
mapkey("n", "<leader>ba", ":%bd|e#|bd#<cr>", noremap)
-- Reselect visual selection after indenting
mapkey("v", "<", "<gv", noremap)
mapkey("v", ">", ">gv", noremap)
-- Remap for dealing with word wrap
mapkey("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
mapkey("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
