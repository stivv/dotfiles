vim.cmd([[
hi Status1 gui=bold guifg=#ffffff guibg=NONE
hi Status2 gui=bold guifg=#38A89D guibg=NONE
hi Status3 gui=bold guifg=#fabd2f guibg=NONE
hi Status4 gui=bold guifg=#fb3333 guibg=NONE
]])

vim.g.status = {
	n = "Normal",
	no = "Normal·Operator Pending",
	v = "Visual",
	V = "V·Line",
	-- '^V' = 'V·Block',
	s = "Select",
	S = "S·Line",
	-- ^S = 'S·Block',
	i = "Insert",
	R = "Replace",
	Rv = "V·Replace",
	c = "Command",
	cv = "Vim Ex",
	ce = "Ex",
	r = "Prompt",
	rm = "More",
	-- r? = 'Confirm',
	-- ! = 'Shell',
	t = "Terminal",
}

local function status_line()
	local mode = "%#Status2# %-5{%g:status[v:lua.vim.fn.mode()]%} "
	local file_name = "%#Status1#  %-.16t"
	local modified = " %-m"
	local branch = " %#Status3# " .. vim.fn.system("git -C . branch --show-current")
	local right_align = "%#Status1#%="
	local diagnostics = "%#Status4#  %{%v:lua.vim.tbl_count(v:lua.vim.diagnostic.get())%}"
	local file_type = "   %#Status1# %Y"
	local line_no = "   %#Status3# %(%l/%L%)"
	local pct_thru_file = "   %#Status2#%2p%%  "

	return string.format(
		"%s%s%s%s%s%s%s%s%s",
		mode,
		file_name,
		modified,
		branch:gsub("\n", ""),
		right_align,
		diagnostics,
		file_type,
		line_no,
		pct_thru_file
	)
end

vim.opt.statusline = status_line()
