vim.cmd([[
hi Status0 gui=bold guifg=#38A89D guibg=#38A89D
hi Status1 gui=bold guifg=#a9b1d6 guibg=NONE
hi Status2 gui=bold guifg=#38A89D guibg=NONE
hi Status3 gui=bold guifg=#fabd2f guibg=NONE
hi Status4 gui=bold guifg=#fb3333 guibg=NONE
]])

vim.g.status = {
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

vim.g.diagnostics = function(type)
	return vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity[type] }))
end

local function status_line()
	local mode = "%#Status0# %#Status2#  %-5{%g:status[v:lua.vim.fn.mode()]%}  "
	local file_name = "%#Status1#  %-.16t"
	local modified = " %#Status4#%M"
	local branch = "  %#Status3# " .. vim.fn.system("git -C . branch --show-current")
	local right_align = "%#Status1#%="
	local hint = "%#Status2#  %{%g:diagnostics('HINT')%}"
	local warn = "%#Status3#  %{%g:diagnostics('WARN')%}"
	local error = "%#Status4#  %{%g:diagnostics('ERROR')%}"
	local file_type = "   %#Status1#%Y"
	local line_no = "   LN%l:COL%c"
	local pct_thru_file = "  %2p%%  %#Status0# "

	return string.format(
		"%s%s%s%s%s%s%s%s%s%s%s",
		mode,
		file_name,
		modified:gsub("+", "s"),
		branch:gsub("\n", ""),
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
