-- Install with: brew install zls
---@type vim.lsp.Config
return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_markers = { 'build.zig', 'build.zig.zon', 'zls.json', '.git' },
  settings = {
    zls = {
      enable_snippets = true,
      enable_argument_placeholders = true,
      enable_build_on_save = false,
    },
  },
}

