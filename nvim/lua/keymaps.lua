-- Keymaps
local mapkey = function(mode, key, cmd, opts)
	local opt = { noremap = true, silent = true }
	if opts then
		for k, v in pairs(opts) do
			opt[k] = v
		end
	end
	return vim.keymap.set(mode, key, cmd, opt)
end

mapkey("n", "<C-a>", "ggVG", { desc = "Select all" })
mapkey("n", "<leader>h", "<cmd>bp<cr>", { desc = "Go to previous buffer" })
mapkey("n", "<leader>l", "<cmd>bn<cr>", { desc = "Go to next buffer" })
mapkey("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close current buffer" })
mapkey("n", "<leader>ba", ":%bd|e#|bd#<cr>", { desc = "Close all buffers" })

-- Reselect visual selection after indenting
mapkey("v", "<", "<gv", { desc = "Move selected to the left" })
mapkey("v", ">", ">gv", { desc = "Move selected to the right" })

-- Better viewing
mapkey("n", "n", "nzzzv")
mapkey("n", "N", "Nzzzv")
mapkey("n", "g,", "g,zvzz")
mapkey("n", "g;", "g;zvzz")

-- Better escape using jj in insert and terminal mode
mapkey("i", "jj", "<Esc>", { desc = "Faster escape" })
mapkey("t", "jj", "<C-\\><C-n>")
mapkey("t", "<C-h>", "<C-\\><C-n><C-w>h")
mapkey("t", "<C-j>", "<C-\\><C-n><C-w>j")
mapkey("t", "<C-k>", "<C-\\><C-n><C-w>k")
mapkey("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Paste over currently selected text without yanking it
mapkey("v", "p", '"_dP')

-- Resize window using <shift> arrow keys
mapkey("n", "<S-Up>", "<cmd>resize +2<CR>")
mapkey("n", "<S-Down>", "<cmd>resize -2<CR>")
mapkey("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
mapkey("n", "<S-Right>", "<cmd>vertical resize +2<CR>")
