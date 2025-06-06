local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_term(opts)
	opts = opts or {}

	-- Create a scratch buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	local width = opts.width or math.floor(vim.o.columns * 0.6)
	local height = opts.height or math.floor(vim.o.lines * 0.6)

	local configs = {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	}

	-- Open floating window
	local win = vim.api.nvim_open_win(buf, true, configs)

	return { buf = buf, win = win }
end

local toggle_term = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_term({ buf = state.floating.buf })
		-- Open term
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.keymap.set("n", "<leader>tt", toggle_term, { silent = true, desc = "Toggle terminal" })
vim.keymap.set("t", "qq", toggle_term, { silent = true, desc = "Toggle terminal" })
