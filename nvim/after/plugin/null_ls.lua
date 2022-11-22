local ok, null_ls = pcall(require, 'null-ls')

if not ok then return end

local on_attach = function(client, buffnr)
	-- Formatting
	if (client.server_capabilities.documentFormattingProvider) then
		vim.api.nvim_command [[ augroup Format ]]
		vim.api.nvim_command [[ autocmd! * <buffer> ]]
		vim.api.nvim_command [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
		vim.api.nvim_command [[ augroup END ]]
	end
end

null_ls.setup {
	on_attach = on_attach,
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with({
			diagnostics_format = '[eslint] #{m}\n(#{c})'
		})
	}
}
