vim.loader.enable()

vim.cmd 'packadd! snacks.nvim'
require 'plugins.snacks'
-- vim.cmd.colorscheme("miss-dracula")
vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH

require 'settings'
require 'keymaps'
require 'commands'
require 'autocmds'
require 'statusline'
require 'winbar'
require 'lsp'

vim.cmd.packadd 'nvim.undotree'
require('vim._core.ui2').enable {}
