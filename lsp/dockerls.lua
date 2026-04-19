-- Install with: npm i -g dockerfile-language-server-nodejs
---@type vim.lsp.Config
return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = { 'Dockerfile', '.git' },
}
