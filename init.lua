vim.loader.enable()

-- vim.cmd.colorscheme("miss-dracula")
vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH

-- Settings
require 'core.options'
require 'core.filetypes'
require 'core.keymaps'
-- Config
require 'commands'
require 'autocmds'
require 'statusline'
require 'winbar'
require 'lsp'

vim.cmd.packadd 'nvim.undotree'
require('vim._core.ui2').enable {}
