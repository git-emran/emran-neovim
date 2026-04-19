-- Install with: brew install texlab
---@type vim.lsp.Config
return {
  cmd = { 'texlab' },
  filetypes = { 'bib', 'tex' },
  root_markers = { '.git', '.latexmkrc', 'texlabroot', 'Tectonic.toml' },
}
