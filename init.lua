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

require("lazy").setup({
	require("plugins.lsp"),
	require("plugins.lazydev"),
	require("plugins.coding"),
	require("plugins.editor-ui"),
	require("plugins.none-ls"),
	require("plugins.treesitter"),
	require("plugins.colortheme"),
	require("plugins.color-highlight"),
	require("plugins.debug"),
	require("plugins.telescope"),
	require("plugins.snacks"),
	require("plugins.trouble"),
	require("plugins.lualine"),
	require("plugins.markdown-render"),
	require("plugins.conform"),
	require("plugins.copilot-supermaven"),
	require("plugins.zenmode"),
	require("plugins.folke-flash"),
	require("plugins.toggle-term"),
	require("plugins.typst"),
	require("plugins.jdtls"),
	require("plugins.roslyn"),
})
