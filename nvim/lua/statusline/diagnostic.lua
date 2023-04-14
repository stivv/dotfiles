local M = {}

M.get = function(type)
	return vim.tbl_count(vim.diagnostic.get(0, { severity = vim.diagnostic.severity[type] }))
end

return M
