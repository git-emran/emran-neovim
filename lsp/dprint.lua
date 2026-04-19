-- Install with: dprint (https://dprint.dev)
---@type vim.lsp.Config
return {
  cmd = { 'dprint', 'lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'markdown',
    'toml',
    'dockerfile',
  },
  root_markers = { 'dprint.json', '.dprint.json', '.git' },
}
