---@type vim.lsp.Config
return {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
  root_markers = {
    '.graphqlrc',
    '.graphqlrc.json',
    '.graphqlrc.yaml',
    '.graphqlrc.yml',
    'graphql.config.json',
    'graphql.config.yaml',
    'graphql.config.yml',
    '.git',
  },
}
