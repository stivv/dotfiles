vim.cmd([[
hi Status0 guifg=#38A89D guibg=#38A89D
hi Status1 guifg=#a9b1d6 guibg=NONE
hi Status2 guifg=#38A89D guibg=NONE
hi Status3 guifg=#fabd2f guibg=NONE
hi Status4 guifg=#fb3333 guibg=NONE
]])

local status_line = function()
	local mode = "%#Status0# %#Status2#  %{%g:statusMode[v:lua.vim.fn.mode()]%} "
	local file_name = "%#Status1#   %t"
	local modified = " %M"
	local branch = "  %#Status3# %{%g:gitBranch%}"
	local right_align = "%#Status1#%="
	local hint = "%#Status2#  %{%v:lua.require('statusline.diagnostic').get('HINT')%}"
	local warn = "%#Status3#  %{%v:lua.require('statusline.diagnostic').get('WARN')%}"
	local error = "%#Status4#  %{%v:lua.require('statusline.diagnostic').get('ERROR')%}"
	local file_type = "   %#Status1#%Y"
	local line_no = "   %l:%c"
	local pct_thru_file = "  %2p%%  %#Status0# "

	return string.format(
		"%s%s%s%s%s%s%s%s%s%s%s",
		mode,
		file_name,
		modified,
		branch,
		right_align,
		hint,
		warn,
		error,
		file_type,
		line_no,
		pct_thru_file
	)
end

vim.opt.statusline = status_line()
