require("core.keymaps")
require("core.options")
require("core.snippets")
require("core.filetypes")

-- Setup lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.runtimepath:prepend(lazypath)

-- List of plugin modules
local plugin_modules = {
	"plugins.lsp",
	"plugins.lazydev",
	"plugins.editor-ui",
	"plugins.none-ls",
	"plugins.treesitter",
	"plugins.colortheme",
	"plugins.color-highlight",
	"plugins.coding",
	"plugins.debug",
	"plugins.telescope",
	"plugins.snacks",
	"plugins.trouble",
	"plugins.lualine",
	"plugins.markdown-render",
	"plugins.conform",
	"plugins.copilot-supermaven",
	"plugins.zenmode",
	"plugins.folke-flash",
	"plugins.toggle-term",
	"plugins.typst",
	"plugins.jdtls",
}

-- Convert module names to require calls
local plugins = {}
for _, module in ipairs(plugin_modules) do
	table.insert(plugins, { import = module })
end

-- Setup lazy.nvim with plugins
require("lazy").setup(plugins)
