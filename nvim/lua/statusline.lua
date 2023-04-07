local function status_line()
	local mode = "%-3{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
	local file_name = "%-.16t"
	local modified = " %-m"
	local right_align = "%="
	local file_type = " %y"
	local line_no = "%10([%l/%L%)]"
	local pct_thru_file = "%5p%%"
	local branch = "  " .. vim.fn.system("git -C . branch --show-current")

	return string.format(
		"%s%s%s%s%s%s%s%s",
		mode,
		file_name,
		modified,
		branch:gsub("\n", ""),
		right_align,
		file_type,
		line_no,
		pct_thru_file
	)
end

vim.opt.statusline = status_line()
