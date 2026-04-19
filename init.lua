pcall(function()
	vim.loader.enable()
end)

-- Ensure Homebrew binaries are in the path.
vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH

require("core.keymaps")
require("core.options")
require("core.snippets")
require("core.filetypes")

-- Setup lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local plugins = "plugins"

-- General setup (order matters here)
require("commands")
require("autocmds")
require("statusline")
require("lsp")

require("lazy").setup(plugins, {
	ui = {
		border = "rounded",
	},
	rocks = { enabled = false },
	install = {
		-- Do not install missing plugins on sfartup.
		missing = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("lsp")

require("vim._core.ui2").enable({})
