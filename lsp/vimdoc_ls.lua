-- Install with: npm i -g vimdoc-language-server
---@type vim.lsp.Config
return {
  cmd = { 'vimdoc-language-server' },
  filetypes = { 'help' },
  root_markers = { '.git' },
}
