-- Install with: cargo install tinymist
---@type vim.lsp.Config
return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
}
