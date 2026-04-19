---@type vim.lsp.Config
return {
  cmd = { 'ltex-ls' },
  filetypes = {
    'bib',
    'gitcommit',
    'markdown',
    'org',
    'plaintex',
    'rst',
    'rnoweb',
    'tex',
    'pandoc',
    'quarto',
    'rmd',
    'context',
    'html',
    'xhtml',
  },
  root_markers = { '.git' },
}
