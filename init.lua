pcall(function()
	vim.loader.enable()
end)

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

---@type LazySpec
local plugins = "plugins"

require("lazy").setup(plugins, {
	ui = {
		border = "rounded",
	},
	install = {
		-- Do not install missing plugins on startup.
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

require("vim._core.ui2").enable({})
