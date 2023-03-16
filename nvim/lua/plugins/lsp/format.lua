local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  vim.notify(M.autoformat and "Enabled format on save" or "Disabled format on save")
end

function M.format()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }
end

function M.on_attach(client, buf)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          if client.name ~= "volar" and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_command [[ augroup Format ]]
            vim.api.nvim_command [[ autocmd! * <buffer> ]]
            vim.api.nvim_command [[ autocmd BufWritePre <buffer> lua M.format() ]]
            vim.api.nvim_command [[ augroup END ]]
          end

          if client.name == "eslint" then
            vim.api.nvim_command [[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll ]]
          end
        end
      end,
    })
  end
end

return M
