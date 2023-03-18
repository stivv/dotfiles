local M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)

	self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
	self:map("gr", "Telescope lsp_references", { desc = "References" })
	self:map("gD", "Telescope lsp_declarations", { desc = "Goto Declaration" })
	self:map("gI", "Telescope lsp_implementations", { desc = "Goto Implementation" })
	self:map("gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
	self:map("K", vim.lsp.buf.hover, { desc = "Hover" })
	self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })
	self:map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
	self:map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
	self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
	self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
	self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
	self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })
	self:map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

	local format = require("plugins.lsp.format").format
	self:map("<leader>cf", format, { desc = "Format Document", has = "documentFormatting" })
	self:map("<leader>cf", format, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })
	self:map("<leader>cr", M.rename, { expr = true, desc = "Rename", has = "rename" })

	self:map("<leader>cs", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
	self:map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
end

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
	return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
	opts = opts or {}
	if opts.has and not self:has(opts.has) then
		return
	end
	vim.keymap.set(
		opts.mode or "n",
		lhs,
		type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
		---@diagnostic disable-next-line: no-unknown
		{ silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
	)
end

function M.rename()
	if pcall(require, "inc_rename") then
		return ":IncRename " .. vim.fn.expand("<cword>")
	else
		vim.lsp.buf.rename()
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M

-- config = function()
-- 	-- Diagnostic keymaps
-- 	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- 	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- 	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- 	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
--
-- 	local ok, lspconfig = pcall(require, "lspconfig")
--
-- 	if not ok then
-- 		return
-- 	end
--
-- 	-- LSP settings.
-- 	--  This function gets run when an LSP connects to a particular buffer.
-- 	local on_attach = function(client, bufnr)
-- 		-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- 		-- to define small helper and utility functions so you don't have to repeat yourself
-- 		-- many times.
-- 		--
-- 		-- In this case, we create a function that lets us more easily define mappings specific
-- 		-- for LSP related items. It sets the mode, buffer and description for us each time.
-- 		local nmap = function(keys, func, desc)
-- 			if desc then
-- 				desc = "LSP: " .. desc
-- 			end
--
-- 			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
-- 		end
--
-- 		nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
-- 		nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
-- 		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
-- 		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
-- 		nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
-- 		nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
-- 		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
-- 		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
-- 		-- See `:help K` for why this keymap
-- 		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
-- 		nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
--
-- 		-- Lesser used LSP functionality
-- 		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
-- 		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
-- 		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
-- 		nmap("<leader>wl", function()
-- 			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- 		end, "[W]orkspace [L]ist Folders")
--
-- 		-- Create a command `:Format` local to the LSP buffer
-- 		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
-- 			if vim.lsp.buf.format then
-- 				vim.lsp.buf.format()
-- 			elseif vim.lsp.buf.formatting then
-- 				vim.lsp.buf.formatting()
-- 			end
-- 		end, { desc = "Format current buffer with LSP" })
--
-- 		require("lsp_signature").on_attach({
-- 			bind = true, -- This is mandatory, otherwise border config won't get registered.
-- 			handler_opts = {
-- 				border = "rounded",
-- 			},
-- 		}, bufnr)
--
-- 		-- Formatting
-- 		if client.name ~= "volar" and client.server_capabilities.documentFormattingProvider then
-- 			vim.api.nvim_command([[ augroup Format ]])
-- 			vim.api.nvim_command([[ autocmd! * <buffer> ]])
-- 			vim.api.nvim_command([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])
-- 			vim.api.nvim_command([[ augroup END ]])
-- 		end
--
-- 		if client.name == "eslint" then
-- 			vim.api.nvim_command([[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll ]])
-- 		end
-- 	end
--
-- 	-- Setup mason so it can manage external tooling
-- 	require("mason").setup()
--
-- 	-- Enable the following language servers
-- 	-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
-- 	local servers = {
-- 		"volar",
-- 		"emmet_ls",
-- 		"eslint",
-- 		"intelephense",
-- 		"rust_analyzer",
-- 		"lua_ls",
-- 		"tailwindcss",
-- 		"jsonls",
-- 		"html",
-- 		"dockerls",
-- 	}
--
-- 	-- Ensure the servers above are installed
-- 	require("mason-lspconfig").setup({
-- 		ensure_installed = servers,
-- 	})
--
-- 	-- nvim-cmp supports additional completion capabilities
-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- 	for _, lsp in ipairs(servers) do
-- 		lspconfig[lsp].setup({
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 		})
-- 	end
--
-- 	-- Turn on lsp status information
-- 	require("fidget").setup()
--
-- 	-- Example custom configuration for lua
-- 	--
-- 	-- Make runtime files discoverable to the server
-- 	local runtime_path = vim.split(package.path, ";")
-- 	table.insert(runtime_path, "lua/?.lua")
-- 	table.insert(runtime_path, "lua/?/init.lua")
--
-- 	lspconfig.lua_ls.setup({
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 		settings = {
-- 			Lua = {
-- 				runtime = {
-- 					-- Tell the language server which version of Lua you're using (most likely LuaJIT)
-- 					version = "LuaJIT",
-- 					-- Setup your lua path
-- 					path = runtime_path,
-- 				},
-- 				diagnostics = {
-- 					globals = { "vim" },
-- 				},
-- 				workspace = {
-- 					library = vim.api.nvim_get_runtime_file("", true),
-- 					checkThirdParty = false,
-- 				},
-- 				-- Do not send telemetry data containing a randomized but unique identifier
-- 				telemetry = { enable = false },
-- 			},
-- 		},
-- 	})
--
-- 	vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
-- 	vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
-- 	vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
-- 	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- end,
