local set = function(lhs, rhs, opts, mode)
	return vim.keymap.set(mode or "n", lhs, rhs, opts or { silent = true })
end

set("jj", "<Esc>", nil, "i")

set("<C-a>", "ggVG")

-- Retain visual mode when tabing
set("<", "<gv", nil, "v")
set(">", ">gv", nil, "v")

set("<S-l>", ":bn<Cr>")
set("<S-h>", ":bp<Cr>")
set("<leader>bd", ":bd<Cr>")
set("<leader>ba", ":%bd!<Cr>")

set(
	"<leader>fe",
	":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<Cr>",
	{ silent = true, desc = "Open file explorer" }
)
set("<leader>fs", ":lua MiniSessions.select()<Cr>", { silent = true, desc = "Select session" })

-- Git
set("<leader>gs", ":Gitsigns preview_hunk<Cr>")
set("<leader>gp", ":Gitsigns prev_hunk<Cr>")
set("<leader>gn", ":Gitsigns next_hunk<Cr>")
