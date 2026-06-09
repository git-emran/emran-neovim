-- Install with: npm i -g vtsls
---@type vim.lsp.Config
return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
}
