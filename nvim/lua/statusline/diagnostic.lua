local M = {}

M.get = function(type)
	local severity = { severity = vim.diagnostic.severity[type] }
	if type == "HINT" then
		severity = { severity = { max = vim.diagnostic.severity["INFO"] } }
	end
	return vim.tbl_count(vim.diagnostic.get(0, severity))
end

return M
