vim.loader.enable()

-- vim.cmd.colorscheme("miss-dracula")
vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH

-- Snacks
vim.cmd 'packadd! snacks.nvim'
require 'plugins.snacks'

-- Settings

require 'core.keymaps'
require 'core.options'
require 'core.filetypes'

-- Config

require 'commands'
require 'autocmds'
require 'statusline'
require 'lsp'
require 'winbar'

vim.cmd.packadd 'nvim.undotree'
require('vim._core.ui2').enable {}
