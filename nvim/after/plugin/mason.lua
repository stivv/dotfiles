local ok, mason = pcall(require, 'mason')
if not ok then return end

local lok, lspconfig = pcall(require, 'mason-lspconfig')
if not lok then return end

mason.setup {}

lspconfig.setup {
  ensure_installed = { 'tailwindcss', }
}
